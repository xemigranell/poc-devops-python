FROM postgres:latest
ENV POSTGRES_PASSWORD=secret
ENV POSTGRES_USER=username
ENV POSTGRES_DB=database
COPY create_init_table.sql /docker-entrypoint-initdb.d/create_init_table.sql