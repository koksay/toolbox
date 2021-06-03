FROM python:3.7-buster

ENV PATH /google-cloud-sdk/bin:/usr/local/aws-cli:$PATH
ENV ANSIBLE_FORCE_COLOR 1

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    echo "deb [arch=amd64] https://apt.releases.hashicorp.com buster main" | tee -a /etc/apt/sources.list.d/terraform.list && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" | tee -a /etc/apt/sources.list.d/docker.list && \
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-get update -y && apt-get install -y --no-install-recommends colordiff jq git terraform google-cloud-sdk kubectl docker-ce docker-ce-cli containerd.io && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && \
    pip3 install --no-cache-dir ansible requests google-auth apache-libcloud psycopg2-binary jmespath docker-compose yq mysqlclient dbbot-sqlalchemy kubernetes-validate openshift boto boto3 botocore && \
    ansible-galaxy collection install google.cloud community.general community.kubernetes amazon.aws && \
    rm -rf /var/lib/apt/lists/*

