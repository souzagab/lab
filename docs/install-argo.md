# Argo CD Installation Guide (This Repository)

**Target Namespace:** `argocd`

## Prerequisites

*   Kubernetes Cluster
*   `kubectl` configured
*   `helm` v3 installed

## Step 1: Initial Helm Installation

1.  **Add Helm Repo:**
    ```bash
    helm repo add argo https://argoproj.github.io/argo-helm
    helm repo update
    ```

2.  **Install Argo CD (Version `7.8.28`):**
    ```bash
    helm upgrade --install argo-cd argo/argo-cd \
      --version 7.8.28 \
      --namespace argocd \
      --create-namespace \
      --wait
    ```
    *This installs Argo CD using its default chart values. The configuration from this repository will be applied in the next step.*

## Step 2: Apply Root Application

This step tells the installed Argo CD to manage itself and other applications based on this Git repository.

1.  **Apply `root-app.yaml`:**
    ```bash
    # Ensure you are in the root directory of this repository
    kubectl apply -f root-app.yaml -n argocd
    ```

Argo CD will now sync itself based on `components/argo-cd.yaml` and `config/argo-cd/values.yaml` from this repository.

## Accessing Argo CD

Refer to the official Argo CD documentation:
[https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli](https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli) 