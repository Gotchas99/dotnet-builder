FROM microsoft/aspnetcore-build
RUN groupadd mygroup && useradd -m -g mygroup myuser
WORKDIR /home/myuser
RUN mkdir app
WORKDIR app
COPY project.json .
RUN dotnet restore

# copy and build everything else
COPY . .
RUN chmod -R +w /home/myuser
USER myuser
WORKDIR /home/myuser/out
ENTRYPOINT ["dotnet", "publish --output /home/myuser/out/. --configuration Release"]
