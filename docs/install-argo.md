# Argo CD Installation Guide (This Repository - Local Chart)

This guide uses the Argo CD Helm chart stored *locally* within this Git repository.

**Target Namespace:** `argocd`

## Prerequisites

*   Kubernetes Cluster
*   `kubectl` configured
*   `helm` v3 installed
*   `git` installed

## Step 1: Clone Repository & Install Chart

1.  **Clone this Git Repository:**
    ```bash
    git clone https://github.com/souzagab/lab
    cd lab
    ```

2.  **Build Helm Dependencies:**
    The Argo CD chart has dependencies (like Redis). Fetch them:
    ```bash
    helm dependency build charts/argo-cd
    ```
    *(Alternatively, use `helm dependency update charts/argo-cd`)*

3.  **Install Argo CD using the Local Chart:**
    This command installs Argo CD using the chart from the `charts/argo-cd` directory within this repository and applies your custom values.
    ```bash
    helm upgrade --install argo-cd ./charts/argo-cd \
      --namespace argocd \
      --create-namespace \
      -f ./charts/argo-cd/custom-values.yaml \
      --wait
    ```
    *   `./charts/argo-cd`: Path to the local chart.
    *   `-f ./charts/argo-cd/custom-values.yaml`: Applies your specific configurations.

## Step 2: Apply Root Application

This step tells the installed Argo CD to manage itself and other applications based on the definitions in this Git repository.

1.  **Apply `root-app.yaml`:**
    ```bash
    # Ensure you are in the root directory of this repository (if not already)
    # cd /path/to/lab
    kubectl apply -f root-app.yaml -n argocd
    ```

Argo CD will now sync itself based on the `Application` definition in `components/argo-cd.yaml`, which points to the chart stored locally in `charts/argo-cd` and uses the values from `charts/argo-cd/custom-values.yaml`.

## Accessing Argo CD

Refer to the official Argo CD documentation:
[https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli](https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli) 