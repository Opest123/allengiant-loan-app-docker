# LoanAppTest

## Getting Started

N.B: Ensure you have installed docker compatible with your system.

---

**Ensure these files are cloned in the same directory**

- [allengiant-loan-app-test-backend](https://github.com/Opest123/allengiant-loan-app-test-backend)
- [allengiant-loan-app-docker](https://github.com/Opest123/allengiant-loan-app-docker)
- [allengiant-loan-app-frontend-test](https://github.com/Opest123/allengiant-loan-app-frontend-test)

---

**Ensure /etc/host file is updated with the variable below:**
<br/>
- 127.0.0.1 loanapp.test
<br />
- 127.0.0.1 backend.loanapp.test

---

**Once the above is done, then run the following in the docker directory:**
<br/>
- make setup or make build && make up

---

**Once the above is done, then run the following in the docker directory to step into the app:**
<br/>
- make php

---

<strong>Once the above is done, then run the following inside the app:</strong>
<br/>
- composer install

---
Frontend URL: http://loanapp.test:5173

---
Backend URL: http://loanapp.test:8004


## CI/CD Notes

Deployment is not strictly required for this project, but here are some general notes around the concept of **Continuous Integration and Continuous Deployment (CI/CD)** for a Laravel + Vue application:

### Continuous Integration (CI)
- **Automated Builds**: Every push to GitHub can trigger a pipeline (e.g., GitHub Actions, GitLab CI, CircleCI).
- **Linting & Formatting**: Run `php artisan lint`, `phpstan`, `eslint` or `prettier` to enforce code standards.
- **Automated Testing**:
    - **Laravel**: Run PHPUnit or Pest tests (`php artisan test`).
    - **Vue**: Run frontend unit tests (e.g., with Jest or Vitest).
- **Docker Build Validation**: Ensure the Docker images for both Laravel (API) and Vue (frontend) build successfully.

### Continuous Deployment (CD)
- **Image Publishing**: On a successful CI pipeline, the app could build Docker images and push them to a registry (Docker Hub, GitHub Container Registry, AWS ECR, etc.).
- **Staging Environment**: Deploy the latest code to a staging server for testing before production.
- **Production Deployment**:
    - Pull the latest Docker images.
    - Run `docker-compose up -d` to recreate services with the latest code.
    - Run Laravel migrations with `php artisan migrate --force`.

### Typical Workflow
1. **Developer pushes code → GitHub**
2. **CI pipeline runs**
    - Install dependencies
    - Run tests (backend + frontend)
    - Build Docker images
3. **If all checks pass → CD step**
    - Push Docker images to registry
    - Deploy to staging/production environment

---

**Key Benefits of CI/CD**
- Catch bugs early via automated testing.
- Keep deployments repeatable and consistent.
- Reduce manual deployment steps and human error.
- Allow faster iteration with confidence.

---
