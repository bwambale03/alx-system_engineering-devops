#!/usr/bin/python3
"""Exports to-do list information of all employees to JSON format."""
import json
import requests

def get_employee_todo_list(employee_id):
    url = f"https://jsonplaceholder.typicode.com/todos?userId={employee_id}"
    response = requests.get(url)
    return response.json()

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    users = requests.get(url + "users").json()

    todo_data = {}
    for user in users:
        employee_id = user["id"]
        employee_name = user["username"]
        todos = get_employee_todo_list(employee_id)
        todo_data[employee_id] = [
            {
                "task": task["title"],
                "completed": task["completed"],
                "username": employee_name
            }
            for task in todos
        ]

    with open("todo_all_employees.json", "w") as jsonfile:
        json.dump(todo_data, jsonfile, indent=2)
