#!/usr/bin/env python3
"""DevOps Student Application — Ruslan Omargali (IT2-2309).

Prints the student's information when it starts and then serves the same
information over HTTP. Values come from environment variables, with the
student's own data as defaults.
"""
import os
import signal
import socket
import sys
from datetime import datetime
from http.server import BaseHTTPRequestHandler, HTTPServer

STUDENT = {
    "Name": os.getenv("STUDENT_NAME", "Ruslan"),
    "Surname": os.getenv("STUDENT_SURNAME", "Omargali"),
    "Group": os.getenv("STUDENT_GROUP", "IT2-2309"),
    "Student ID": os.getenv("STUDENT_ID", "37858"),
}
PORT = int(os.getenv("APP_PORT", "8000"))
STARTED = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
LINE = "=" * 32


def banner() -> str:
    lines = [LINE, "DevOps Student Application", LINE, ""]
    lines += [f"{key}: {value}" for key, value in STUDENT.items()]
    lines += [
        "",
        f"Container: {socket.gethostname()}",
        f"Started:   {STARTED}",
        "",
        "Application is running successfully!",
    ]
    return "\n".join(lines)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = "OK\n" if self.path == "/health" else banner() + "\n"
        data = body.encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def log_message(self, fmt, *args):
        now = datetime.now().strftime("%H:%M:%S")
        print(f"[{now}] {self.address_string()} {fmt % args}", flush=True)


def main():
    print(banner(), flush=True)
    print(f"\nListening on port {PORT}", flush=True)
    # Stop quickly on `docker stop` (SIGTERM)
    signal.signal(signal.SIGTERM, lambda *_: sys.exit(0))
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()


if __name__ == "__main__":
    main()
