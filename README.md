# 🧠 Basic EDA Demo

This repository provides a minimal and educational demonstration of **Event-Driven Ansible (EDA)**, including:

- A simple **Ansible Rulebook** that listens for events and prints the received payload
- A pair of shell scripts to test event delivery locally or remotely to an EDA server

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
   - Calling an API
   - Setting a fact, etc.

EDA brings reactive automation to life by combining these elements in a declarative YAML format.

---

## 📁 Repository Structure

```
basic_eda_demo/
├── rulebooks/
│   └── print_payload.yml
├── scripts/
│   ├── send_local.sh
│   └── send_to_eda.sh
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

This directory includes two shell scripts:

- **`send_local.sh`**  
  Sends a sample JSON payload to a local webhook listener on `localhost:5005`. Useful for testing the rulebook locally.

- **`send_to_eda.sh`**  
  Sends a similar payload to a remote **EDA Controller server**. You’ll need to adjust the URL and token for your environment.

Both scripts are basic templates and can be extended to simulate different events.

---

## 🚀 Quick Start

1. **Start the rulebook listener**

```bash
ansible-rulebook -i localhost, \
  --rulebook rulebooks/print_payload.yml \
  --verbose
```

2. **Send a test event**

```bash
./scripts/send_local.sh
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
- Refer to the [Red Hat EDA docs](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.4/html/event-driven_ansible_controller_user_guide/index) for advanced use cases

---

## 🙌 Credits

Maintained by [@daleroux](https://github.com/daleroux) — feel free to fork and extend.
