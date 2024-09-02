# 🌟 Time API - Local Setup Guide

Welcome to the **Time API**! This simple API returns the current UTC time in a JSON format when accessed via a GET request. Whether you're testing locally or integrating it into a larger application, this guide will help you get up and running quickly.

## 🚀 Getting Started

### Prerequisites

Before you start, make sure you have the following installed on your machine:

- **Python 3.8+**: The core language used to build the API.
- **pip**: Python's package installer.
- **Docker** (Optional): For running the API in a containerized environment.

### 1. Clone the Repository

Start by cloning this repository to your local machine:

```bash
git clone https://github.com/1AMTEDDY/time-api.git
cd time-api
```

### 2. Set Up the Virtual Environment (Optional but Recommended)

It's good practice to create a virtual environment to manage your dependencies. Here's how you can do it:

```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies

Install the required Python packages using pip:

```bash
pip install -r requirements.txt
```

### 4. Run the API

Now that everything is set up, you can run the API locally:

```bash
python app.py
```

By default, the API will be accessible at `http://127.0.0.1:8080/time`.

### 5. Test the API

To ensure everything is working correctly, you can test the API by sending a GET request:

```bash
curl http://127.0.0.1:8080/time
```

You should receive a response similar to this:

```json
{
  "current_time": "2024-09-01T12:34:56.789Z"
}
```

## 🐳 Running the API with Docker

If you prefer running the API in a container, Docker is your friend! Follow these steps:

### 1. Build the Docker Image

Build the Docker image using the provided `Dockerfile`:

```bash
docker build -t time-api:latest .
```

### 2. Run the Docker Container

Run the container:

```bash
docker run -d -p 8080:8080 time-api:latest
```

The API will now be accessible at `http://127.0.0.1:8080/time`.

### 3. Stop the Docker Container

To stop the container, you can use:

```bash
docker ps  # Find the container ID
docker stop <container-id>
```

## 🔧 Troubleshooting

### Common Issues

- **Port Conflicts**: If port `8080` is already in use, you can change the port by modifying the `app.py` file or the Docker `-p` flag.
- **Dependency Issues**: Ensure all dependencies in `requirements.txt` are installed correctly. Run `pip install -r requirements.txt` again if you encounter issues.

### Need Help?

If you encounter any issues or have questions, feel free to open an issue in this repository or contact me at [petersonwoko@gmail.com](mailto:petersonwoko@gmail.com).

## 🌟 Features

- **Simple and Lightweight**: A minimalist API that does one thing well.
- **Docker Support**: Easily containerize the API for deployment in any environment.
- **Pythonic**: Built with Python, leveraging Flask for a clean and simple implementation.

## ✨ Contributing

If you'd like to contribute to this project, please fork the repository and use a feature branch. Pull requests are warmly welcome.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
