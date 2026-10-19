# omargali-ruslan-devops

Personal DevOps laboratory project (Laboratory work 1: Linux, Git, Docker, Jenkins).

| | |
|---|---|
| Student | Ruslan Omargali |
| Group | IT2-2309 |
| Student ID | 37858 |
| Course | DevOps |

## Project structure

```
omargali_ruslan/
├── app/                     # application that runs inside Docker
├── scripts/                 # Linux Bash scripts
├── config/                  # configuration files
├── logs/                    # application logs (ignored by Git)
└── backup/                  # local backups (ignored by Git)
```

## Run with Docker

```bash
docker build -t omargali-ruslan-devops .
docker run --name omargali-ruslan-container omargali-ruslan-devops
```

## Run with Docker Compose

```bash
docker compose up -d     # http://localhost:8000
docker compose down
```

## Jenkins

`jenkins/` contains a local Jenkins server with Docker CLI.
Pipeline job `Omargali_Ruslan_DevOps` uses the `Jenkinsfile` from this repository:
Checkout → Build → Test → Docker Build → Docker Run.
