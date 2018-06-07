FROM hortonworks/docker-e2e-protractor

RUN cp /entrypoint.sh /usr/local/bin/run-protractor
RUN chmod +x /usr/local/bin/run-protractor

WORKDIR /protractor/project

ENTRYPOINT []
