set host=localhost
set user=postgres
set SQL_password=root
set db_name=testtask
set port=5432

uvicorn main:app --reload
