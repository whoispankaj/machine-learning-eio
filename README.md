# machine-learning-eio
This is the Educative IO machine learning project

## Setup

The project uses a Python virtual environment in `.venv`. Manage it with `scripts/env.sh`.
Run the script with `source`, not directly, so it can change your current shell.

```sh
source scripts/env.sh              # activate (re-activates if one is already active)
source scripts/env.sh deactivate   # deactivate
```

The first time you activate, the script creates `.venv` and installs `requirements.txt`.

### Installing requirements manually

After the first run the script does not reinstall packages. If you add a package to
`requirements.txt`, activate the environment first and then install:

```sh
source scripts/env.sh
pip install -r requirements.txt
```

### Rebuilding the environment

To start over with a fresh environment, delete `.venv` and activate again:

```sh
source scripts/env.sh deactivate
rm -rf .venv
source scripts/env.sh
```

## Running

Activate the environment first, then run either of these:

```sh
python src/main.py
./src/main.py
```

The script reads its data from `dataset/pizza.txt`.
