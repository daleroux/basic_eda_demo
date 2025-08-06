# 🔁 Basic EDA Demo

This repository provides a minimal and educational demonstration of **Event-Driven Ansible (EDA)**, including:

- A simple **Ansible Rulebook** that listens for events and prints the received payload
- Three shell scripts to test event delivery locally or remotely to an EDA server

---

## 📘 What is an Ansible Rulebook?

An **Ansible Rulebook** defines event-driven logic, similar to "if-this-then-that" automation. It is composed of three core components:

1. **Source(s)**  
   The origin of events. Common sources include webhooks, timers, or message queues (Kafka, AMQ, etc.)

2. **Rule(s)**  
   Conditional logic that matches event payloads (`if condition then ...`). Rules define when actions should trigger.

3. **Action(s)**  
   What to do when a rule matches — this could include:
   - Printing the event (`debug`, `print_event`)
   - Running an Ansible playbook
   - Running a Workflow, etc


---

## 📁 Repository Structure

```
basic_eda_demo/
├── rulebooks/
│   └── print_payload.yml
├── scripts/
│   ├── send_payload_to_localhost.sh
│   └── send_payload_to_eda.sh
│   └── set_eda_env.sh
└── README.md
```

### 📂 `rulebooks/`

Contains a simple rulebook: **`print_payload.yml`**

This rulebook:
- Starts a local webhook listener on port 5005
- Waits for incoming JSON events
- Uses a rule with a condition that always evaluates to `true`
- Executes a `debug` action to **print the full event payload** to standard output

This is useful for validating that payloads are properly received and processed.

### 📂 `scripts/`

This directory includes three shell scripts:

- **`send_payload_to_localhost.sh`**  
  Sends a sample JSON payload to a local webhook listener on `localhost:5005`. Useful for testing the rulebook locally.

- **`set_eda_env.sh`**  
  This will ask for the Event Stream URL and Token, which will then be used by `send_payload_to_eda.sh`. This script needs to be sourced

```bash
  source set_eda_env.sh
```   

- **`send_payload_to_eda.sh`**  
  Sends a similar payload to the Event Stream of a remote **EDA Controller server**. Make sure to first source `set_eda_env.sh` before running
---

## 🚀 Quick Start

1. **Start the rulebook listener**

```bash
ansible-rulebook -r rulebooks/print_payload.yml \
  --verbose
```

2. **Send a test event**

```bash
./scripts/send_payload_to_localhost.sh
```

3. **Observe the output** — The printed event data should appear in your terminal.

---

## ✅ Sample Rulebook: `print_payload.yml`

```yaml
- name: Echo incoming payload
  hosts: localhost
  sources:
    - ansible.eda.webhook:
        host: 0.0.0.0
        port: 5005
  rules:
    - name: Always print event
      condition: true
      action:
        debug:
```

- **Source**: Webhook listener on port 5005  
- **Rule**: Matches all events  
- **Action**: `debug` prints the payload and metadata

---

## 🛠 Requirements

- Python 3.9+
- [`ansible-rulebook`](https://ansible.readthedocs.io/projects/rulebook/)
- Java 17+ (for `jpy` backend, used by ansible-rulebook engine)
- EDA-compatible runtime (if using remote controller)

---

## 📌 Notes

- This demo is local and stateless by design
- You can integrate other sources (e.g., Kafka) and actions (e.g., playbooks) by extending the rulebook
- Refer to the [Ansible Rulebook documentation](https://ansible.readthedocs.io/projects/rulebook/en/v1.1.7/) for advanced use cases

---

## Credits

Maintained by [@daleroux](https://github.com/daleroux) — feel free to fork and extend.
