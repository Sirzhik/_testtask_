# Тестове завдання
## Документація до API

>### Admin endpoints
>
> *Базовий токен до акаунту admin - **ca9f259c4ee8f0d81aef1578fe855752***
>

/admin/adduser/{admin_token} - 
Додає у БД користувача. У URL запитує token

**POST**
Приклад запиту:

```python
payload = {
    'username': 'name',
    'password': 'password',
    'manager': 1
}
requests.post(url, json=payload)
```

/admin/addmanager/{admin_token} - 
Додає у БД менеджера. У URL запитує token


**POST**
Приклад запиту:

```python
payload = {
    'username': 'name',
    'password': 'password'
}

requests.post(url, json=payload)
```

/admin/users/{admin_token} - повертає JSON формату *ID: nick*. У URL запитує token


**GET**
```python
requests.get(url)
```

### Manager endpoints

/manager/check/{manager_token} - Може передивлятись записи своїх юзерів. У URL запитує token


**POST**
```python
payload = {
    'user_id': 12345,
    'manager_id': 12346
}

requests.post(url, json=payload)
```

### User endpoints

/send/{token} - Надсилає повідомлення за вказаним **chatid** від імені телеграм бота вказаного за **bottoken**. У URL запитує token

**POST**
```python
payload = {
    'bottoken': "12345",
    'chatid': 12346,
    'message': 'повідомлення'
}

requests.post(url, json=payload)
```

/auth - Приймає **username** та **password** у тілі запиту, та повертає **token**

**POST**
```python
payload = {
    'username': "user1",
    'password': '4444'
}

requests.post(url, json=payload)
```

/changepassword/{token} - Зчитує **token** з URL та бере з тіла запиту оновлений пароль, після чого у записі користувача у таблиці users колонка password змінюється. 


**POST**

```python
payload = {
    'password': '4444'
}

requests.post(url, json=payload)
```
