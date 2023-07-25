import requests
import sys


def get_employee_todo_progress(employee_id):
    base_url = "https://jsonplaceholder.typicode.com"
    employee_url = f"{base_url}/users/{employee_id}"
    todos_url = f"{base_url}/todos?userId={employee_id}"

    try:
        employee_response = requests.get(employee_url)
        employee_response.raise_for_status()
        todos_response = requests.get(todos_url)
        todos_response.raise_for_status()

        employee_data = employee_response.json()
        todos_data = todos_response.json()

        employee_name = employee_data["name"]
        total_tasks = len(todos_data)
        done_tasks = sum(1 for task in todos_data if task["completed"])

        print(
            f"Employee {employee_name} is done with
            tasks({done_tasks}/{total_tasks}): ")
        for task in todos_data:
            if task["completed"]:
                print(f"\t{task['title']}")

    except requests.exceptions.RequestException as e:
        print("Error while fetching data:", e)
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py EMPLOYEE_ID")
        sys.exit(1)

    try:
        employee_id = int(sys.argv[1])
        get_employee_todo_progress(employee_id)
    except ValueError:
        print("Employee ID must be an integer.")
        sys.exit(1)
