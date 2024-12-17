import argparse
from datetime import datetime, timedelta
from typing import Literal
from dataclasses import dataclass
import secrets
import sqlite3
import os


@dataclass(slots=True)
class Data:
    id: str
    title: str
    created_at: datetime
    option: Literal["idea", "todo"]
    status: Literal["done", "pending", "expired"]


home = os.getenv("HOME")
conn = sqlite3.connect(f"{home}/personal/notes/gg.db")

cur = conn.cursor()


def setup_tables():
    sql = "CREATE TABLE IF NOT EXISTS data(id, title,created_at, option, status);"
    cur.execute(sql)


def create_data(todo: Data):
    query = "INSERT INTO data VALUES(?,?,?,?,?)"
    cur.execute(
        query,
        (
            todo.id,
            todo.title,
            todo.created_at,
            todo.option,
            todo.status,
        ),
    )
    conn.commit()


def update_todo(id: str, status: Literal["done", "expired"]):
    query = "UPDATE data SET status = ? WHERE id = ? AND option='todo'"
    cur.execute(query, (status, id))
    conn.commit()


def get_todos(option: Literal["all", "pending"] = "pending"):
    query = ""
    if option == "pending":
        query = "SELECT * FROM data WHERE status = 'pending' AND option='todo';"
    else:
        query = "SELECT * from data WHERE option='todo';"

    results = cur.execute(query)

    return results.fetchall()


def get_ideas():
    query = "SELECT * from data WHERE option='idea';"
    results = cur.execute(query)
    return results.fetchall()


def gen_id(len=4):
    return secrets.token_hex(len)


def is_expired(created_at: datetime):
    now = datetime.now()
    expiration = created_at + timedelta(hours=24)
    time_left = expiration - now
    expired = time_left <= timedelta(0)

    days = time_left.days
    hours = time_left.seconds // 3600
    minutes = (time_left.seconds // 60) % 60

    if days > 0:
        time_left_str = f"{days} days"
    elif hours > 0:
        time_left_str = f"{hours} hrs"
    elif minutes > 0:
        time_left_str = f"{minutes} min"
    else:
        time_left_str = "0 min"

    return time_left_str, expired


def list_ideas():
    ideas = get_ideas()
    if len(ideas) == 0:
        return
    print_banner()
    for idea in ideas:
        print(f"{idea[1]}")


def list_todos(option: Literal["full", "simple", "all"] = "simple"):
    todos = get_todos()
    if len(todos) == 0:
        return

    print_banner()
    if option == "simple":
        for todo in todos:
            time_left, expired = is_expired(datetime.fromisoformat(todo[2]))
            if expired:
                update_todo(todo[0], "expired")
            print(f"~'{todo[1]}'")
        return
    if option == "full":
        for todo in todos:
            time_left, expired = is_expired(datetime.fromisoformat(todo[2]))
            if expired:
                update_todo(todo[0], "expired")
                return

            print(f"{todo[0]} | '{todo[1]}' expires in {time_left}")
        return

    for todo in todos:
        print(f"{todo[0]} | '{todo[1]}' | {todo[4]}")


def handle_entry(option: Literal["idea", "todo"], title: str = ""):
    if not title:
        prompt = "What ya thinking about\n>" if option == "idea" else "What to do\n>"
        title = input(prompt)

    now = datetime.now()
    idea = Data(
        id=gen_id(),
        title=title,
        created_at=now,
        option=option,
        status="thinking" if option == "idea" else "pending",
    )
    create_data(idea)
    print("Logged entry")


def main():
    setup_tables()
    parser = argparse.ArgumentParser(
        description="Trying to manage stuff\nTodos are daily"
    )
    parser.add_argument(
        "-i", "--idea", action="store_true", help="quickly note an idea"
    )

    parser.add_argument(
        "-it",
        "--inline-todo",
        help="Add an entry directly",
    )
    parser.add_argument(
        "-id",
        "--inline-idea",
        help="Add an entry directly",
    )
    parser.add_argument(
        "-t", "--todo", action="store_true", help="write down quick todos"
    )
    parser.add_argument("-md", "--mark_done", help="mark a todo as done")

    parser.add_argument(
        "-li",
        "--list_all_ideas",
        action="store_true",
        help="List all ideas",
    )
    parser.add_argument(
        "-lat",
        "--list_all_todos",
        action="store_true",
        help="List all todos icluding ids",
    )
    parser.add_argument(
        "-lft",
        "--list_full_todos",
        action="store_true",
        help="List today's todos and pending ones including ids",
    )
    parser.add_argument(
        "-lst",
        "--list_simple_todos",
        action="store_true",
        help="List today's todos and pending ones",
    )

    args = parser.parse_args()
    if args.idea:
        handle_entry("idea")
    elif args.todo:
        handle_entry("todo")
    elif args.inline_idea:
        handle_entry("idea", args.inline_idea.strip())
    elif args.inline_todo:
        handle_entry("todo", args.inline_todo.strip())
    elif args.list_all_todos:
        list_todos("all")
    elif args.list_full_todos:
        list_todos("full")
    elif args.list_simple_todos:
        list_todos()
    elif args.list_all_ideas:
        list_ideas()
    elif args.mark_done:
        update_todo(args.mark_done, "done")
    else:
        parser.print_help()


def print_banner():
    print(
        """
 /)/)
( . .) ?
      """
    )


if __name__ == "__main__":
    main()
