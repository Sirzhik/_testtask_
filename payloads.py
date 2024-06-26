from pydantic import BaseModel


class SendArgs(BaseModel):
    bottoken: str
    chatid: int
    message: str

class RegManagerArgs(BaseModel):
    username: str
    password: str

class RegUserArgs(BaseModel):
    username: str
    password: str
    manager: int

class Auth(BaseModel):
    username: str
    password: str

class ChangePassword(BaseModel):
    password: str

class ManagerCheck(BaseModel):
    user_id: int
    manager_id: int
