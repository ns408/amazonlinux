FROM amazonlinux

ARG user

RUN yum -y update && yum -y upgrade && \
    yum -y install \
    awscli unzip tar sudo shadow-utils curl wget groff \
    less file

RUN cd /tmp && \
    curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -q awscliv2.zip && \
    ./aws/install
RUN /usr/local/bin/aws2 --version || (echo "Couldn't find aws2 binary"; exit 1)

# Just throwing this as an example
# Probably should be done in a multi-staged way
# so the script can be executed as a non-root user
COPY bin/setup.sh /tmp/setup.sh
RUN /tmp/setup.sh

RUN echo "Clean-up time"; \
    rm -rf /tmp/aws* /tmp/setup.sh; \
    yum -y clean all && rm -rf /var/cache/yum

RUN useradd --no-log-init --create-home --user-group $user

# sudoers entry for the user
RUN echo "$user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user \
  && chmod 0400 /etc/sudoers.d/$user

ENV PATH="/home/${user}/bin:/usr/local/bin:${PATH}"
ENV HISTFILE="/home/${user}/host_mount/.bash_history"
