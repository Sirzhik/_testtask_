from fastapi import FastAPI, HTTPException
from payloads import SendArgs, RegUserArgs, RegManagerArgs, Auth, ChangePassword, ManagerCheck
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine
from time import asctime
from permissions import is_admin, is_manager
from envs import sql_host, sql_password, sql_db_name, sql_user_name, sql_port
from aiogram import Bot


import hashlib
import json

app = FastAPI()
engine = create_async_engine(url=f'postgresql+asyncpg://{sql_user_name}:{sql_password}@{sql_host}:{sql_port}/'
                                 f'{sql_db_name}')


async def send(token, chat_id, text: str):
    bot = Bot(token=token)
    await bot.send_message(chat_id=chat_id, text=text)
    await bot.session.close()


@app.post('/send/{token}')
async def send_message(token: str, args: SendArgs):
    try:
        async with engine.connect() as connection:
            result = await connection.execute(text("SELECT id FROM users WHERE token = :token"), {'token': token})
            user_id = result.fetchone()[0]
            print(user_id)
            print(args)

            ret_request = {
                'bottoken': args.bottoken,
                "chatid": args.chatid,
                "message": args.message
            }

            response = {'response': 'Sended'}

            try:
                await send(token=args.bottoken, chat_id=args.chatid, text=args.message)

                await connection.execute(text(
                    "INSERT INTO requests (request, response, sender) VALUES (:request, :response, :sender)"),
                    {
                        'request': json.dumps(ret_request, ensure_ascii=False),
                        'response': json.dumps(response, ensure_ascii=False),
                        'sender': user_id
                    }
                )
                await connection.commit()

                return ret_request

            except Exception as e:
                error_response = {"send_error": str(e)}
                await connection.execute(text(
                    "INSERT INTO requests (request, response, sender) VALUES (:request, :response, :sender)"),
                    {
                        'request': json.dumps(ret_request, ensure_ascii=False),
                        'response': json.dumps(error_response, ensure_ascii=False),
                        'sender': user_id
                    }
                )
                await connection.commit()

                return error_response

    except Exception as e:
        return {"db_connect_error": str(e)}


@app.post('/manager/check/{manager_token}')
async def check(manager_token: str, args: ManagerCheck):
    if not await is_manager(manager_token):
        raise HTTPException(status_code=403, detail="Forbidden: Only managers can do this")

    try:
        async with engine.connect() as connection:
            res = await connection.execute(text('SELECT manager FROM groups WHERE subuser = :subuser'), {'subuser': args.user_id})
            manager_id = res.fetchone()[0]

            if manager_id == args.manager_id:
                ret = await connection.execute(text('SELECT * FROM requests WHERE sender = :sender'), {'sender': args.user_id})
                result = ret.fetchall()

                serialized_result = [
                    dict(row._mapping) for row in result
                ]

                return serialized_result

    except Exception as e:
        return {"error": str(e)}


@app.post('/admin/adduser/{admin_token}')
async def add_user(admin_token: str, args: RegUserArgs):
    if not await is_admin(admin_token):
        raise HTTPException(status_code=403, detail="Forbidden: Only admins can add users")

    try:
        password = hashlib.md5(args.password.encode()).hexdigest()
        token = hashlib.md5(asctime().encode()).hexdigest()

        async with engine.connect() as connection:
            await connection.execute(text(
                "INSERT INTO users (username, password, token, roleid) VALUES (:username, :password, :token, :roleid)"),
                {'username': args.username, 'password': password, 'token': token, 'roleid': 1}
            )
            await connection.commit()

            result = await connection.execute(text("SELECT id FROM users WHERE token = :token"), {'token': token})
            user_id = result.fetchone()[0]

            await connection.execute(text(
                "INSERT INTO groups (manager, subuser) VALUES (:manager, :subuser)"),
                {'manager': args.manager, 'subuser': user_id}
            )
            await connection.commit()

            return {
                "username": args.username,
                "password": password,
                "token": token,
                "roleid": 1,
                "response": "OK"
            }

    except Exception as e:
        return {"error": str(e)}


@app.post('/admin/addmanager/{admin_token}')
async def add_manager(admin_token: str, args: RegManagerArgs):
    if not await is_admin(admin_token):
        raise HTTPException(status_code=403, detail="Forbidden: Only admins can add managers")

    try:
        password = hashlib.md5(args.password.encode()).hexdigest()
        token = hashlib.md5(asctime().encode()).hexdigest()

        async with engine.connect() as connection:
            await connection.execute(text(
                "INSERT INTO users (username, password, token, roleid) VALUES (:username, :password, :token, :roleid)"),
                {'username': args.username, 'password': password, 'token': token, 'roleid': 2}
            )
            await connection.commit()

            return {
                "username": args.username,
                "password": password,
                "token": token,
                "response": "OK"
            }

    except Exception as e:
        return {"error": str(e)}


@app.get('/admin/users/{admin_token}')
async def get_users(admin_token: str):
    if not await is_admin(admin_token):
        raise HTTPException(status_code=403, detail="Forbidden: Only admins can get list of users")

    try:
        async with engine.connect() as connection:
            result = await connection.execute(text("SELECT id, username FROM users"))
            users = result.fetchall()

            # Формуємо список словників з результатів
            users_list = [{"id": user[0], "username": user[1]} for user in users]

            return users_list

    except Exception as e:
        return {"error": str(e)}


@app.post('/auth')
async def auth(args: Auth):
    try:
        password = hashlib.md5(args.password.encode()).hexdigest()

        async with engine.connect() as connection:
            result = await connection.execute(text("SELECT token FROM users WHERE username = :username AND password = "
                                                   ":password;"),
                                              {'username': args.username, 'password': password})
            return {"token": result.fetchone()[0]}

    except Exception as e:
        return {"error": str(e)}


@app.post('/changepassword/{token}')
async def change(token: str, args: ChangePassword):
    try:
        password = hashlib.md5(args.password.encode()).hexdigest()

        async with engine.connect() as connection:
            await connection.execute(text("UPDATE users SET password = :password WHERE token = :token;"),
                                     {'token': token, 'password': password})
            await connection.commit()

            return {"password": "changed"}

    except Exception as e:
        return {"error": str(e)}
