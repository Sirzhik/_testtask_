from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine


engine = create_async_engine(url='postgresql+asyncpg://postgres:root@localhost:5432/testtask')


async def is_admin(token: str) -> bool:
    async with engine.connect() as connection:
        result = await connection.execute(text("SELECT roleid FROM users WHERE token = :token"), {'token': token})
        user_status = result.fetchone()
        if user_status and user_status[0] == 3:
            return True
        return False

async def is_manager(token: str) -> bool:
    async with engine.connect() as connection:
        result = await connection.execute(text("SELECT roleid FROM users WHERE token = :token"), {'token': token})
        user_status = result.fetchone()
        if user_status and user_status[0] == 2:
            return True
        return False
