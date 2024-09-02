# 🌟 Time API - Local Setup Guide with Terraform and Google Cloud

Welcome to the **Time API**! This guide will help you set up and deploy the Time API using Terraform on Google Cloud Platform (GCP), both locally and via GitHub Actions. Whether you're working locally or setting up CI/CD pipelines, this documentation has you covered. We'll also explore how to enforce security policies with Open Policy Agent (OPA) during Terraform deployments.

## 🚀 Getting Started

### Prerequisites

Before you start, ensure you have the following tools installed:

- **Python 3.8+**: To run the API locally.
- **pip**: Python's package installer.
- **Docker** (Optional): For running the API in a containerized environment.
- **Terraform**: For managing infrastructure as code.
- **Google Cloud SDK**: To interact with GCP.
- **GitHub CLI**: To manage repositories and workflows.

### 1. Clone the Repository

Begin by cloning this repository to your local machine:

```bash
git clone https://github.com/1AMTEDDY/time-api.git
cd time-api
```

### 2. Set Up the Virtual Environment (Optional but Recommended)

It's good practice to create a virtual environment to manage your dependencies:

```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies

Install the required Python packages:

```bash
pip install -r requirements.txt
```

### 4. Run the API Locally

Run the API on your local machine:

```bash
python app.py
```

The API will be accessible at `http://127.0.0.1:8080/time`.

### 5. Test the API

Verify that the API is working:

```bash
curl http://127.0.0.1:8080/time
```

You should see a JSON response with the current time:

```json
{
  "current_time": "2024-09-01T12:34:56.789Z"
}
```

## 🐳 Running the API with Docker

### 1. Build the Docker Image

```bash
docker build -t time-api:latest .
```

### 2. Run the Docker Container

```bash
docker run -d -p 8080:8080 time-api:latest
```

The API will be accessible at `http://127.0.0.1:8080/time`.

### 3. Stop the Docker Container

```bash
docker ps  # Find the container ID
docker stop <container-id>
```

## 🛠️ Setting Up Terraform with Google Cloud

### Folder Structure

Your Terraform configuration is organized as follows:

```bash
terraform/
│
├── main.tf          # The main Terraform configuration file
├── outputs.tf       # Output definitions
├── policy.rego      # OPA policy for security checks
├── roles.tfvars     # IAM roles configuration
├── variables.tf     # Input variable definitions
└── modules/         # Module directory
    ├── gke/         # GKE cluster setup
    ├── iam/         # IAM roles and permissions
    ├── k8s/         # Kubernetes resources
    └── network/     # VPC and networking
```

### Authenticating with Google Cloud Locally

1. **Install the Google Cloud SDK**:

   ```bash
   brew install --cask google-cloud-sdk
   ```

2. **Authenticate with Google Cloud**:

   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID
   ```

3. **Set Up Terraform Backend**:

   Ensure your `main.tf` includes the backend configuration for GCP:

   ```hcl
   terraform {
     backend "gcs" {
       bucket = "your-terraform-backend-bucket"
       prefix = "terraform/state"
     }
   }
   ```

   Initialize Terraform:

   ```bash
   terraform init
   ```

4. **Run Terraform Commands Locally**:

   - **Plan**:

     ```bash
     terraform plan -out=tfplan.binary -var "project_id=YOUR_PROJECT_ID" -var "container_image=YOUR_DOCKER_USERNAME/api:latest" -var-file="roles.tfvars"
     ```

   - **Apply**:

     ```bash
     terraform apply -auto-approve -var "project_id=YOUR_PROJECT_ID" -var "container_image=YOUR_DOCKER_USERNAME/api:latest" -var-file="roles.tfvars"
     ```

### Setting Up Terraform in GitHub Actions

In your GitHub repository, you can set up Terraform with the following steps:

1. **Add Secrets**:
   - Go to your GitHub repository.
   - Navigate to **Settings > Secrets > Actions**.
   - Add the following secrets:
     - `GCP_KEY`: Base64-encoded JSON key for your service account.

     ``` bash
     base64 -i path-to-your-file.json -o encoded-output.txt
     ```

     - `GCP_PROJECT_ID`: Your Google Cloud project ID.
     - `DOCKER_USERNAME`: Your Docker Hub username.
     - `DOCKER_PASSWORD`: Your Docker Hub password.

### 🔐 OPA Policy Enforcement with `policy.rego`

The `policy.rego` file defines security policies to enforce during Terraform deployments using Open Policy Agent (OPA). Here's what it does:

- **Deny Rule**: Blocks public access to ports 22 and 8080 on `google_compute_firewall` resources to prevent unauthorized access to sensitive services.

- **Allow Rule**: Permits public access to ports 80 (HTTP) and 443 (HTTPS) on `google_compute_firewall` resources, ensuring that only web traffic is allowed.

This policy helps ensure that your infrastructure remains secure by preventing the exposure of sensitive ports to the internet.

## 🔧 Troubleshooting

### Common Issues

- **GCP Authentication Issues**: Ensure your service account has the necessary permissions and that you're using the correct JSON key.
- **Terraform Errors**: Validate your Terraform configuration files and ensure all required variables are set.

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
