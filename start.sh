#!/usr/bin/env bash

export host='localhost'
export user='postgres'
export SQL_password='root'
export db_name='testtask'
export port='5432'

uvicorn main:app --reload
