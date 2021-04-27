FROM python:3-slim
WORKDIR /app
RUN apt update -y && apt install -y curl jq git
RUN pip install yq pipx
COPY . .
CMD ["/app/entrypoint.sh"]