<strong>LoanAppTest</strong>

<hr/>
## Getting Started
<hr/>

N.B: Ensure you have installed docker compatible with your system.

<hr/>

<strong>Ensure these files are cloned in the same directory</strong>

- allengiant-loan-app-test-backend
- allengiant-loan-app-docker
- allengiant-loan-app-frontend-test

<hr/>

<strong>Ensure /etc/host file is updated with the variable below:</strong>
<br/>
- 127.0.0.1 loanapp.test
<br />
- 127.0.0.1 backend.loanapp.test

<hr/>

<strong>Once the above is done, then run the following in the docker directory:</strong>
<br/>
- make setup or make build && make up

<hr/>

<strong>Once the above is done, then run the following in the docker directory to step into the app:</strong>
<br/>
- make php

<hr/>

<strong>Once the above is done, then run the following inside the app:</strong>
<br/>
- composer install

<hr/>

Frontend URL: http://loanapp.test:8084/

<hr/>

Backend URL: http://loanapp.test:8004


