# Sử dụng Python slim image
FROM python:3.10-slim

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    curl unzip build-essential \
    && rm -rf /var/lib/apt/lists/*

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Cài đặt các thư viện Python cần thiết
RUN pip install --upgrade pip
RUN pip install -r requirements.txt || true

# Chạy song song 2 script
CMD bash -c "python main_combined.py & python main.py"
