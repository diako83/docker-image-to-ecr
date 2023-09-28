FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS Build
WORKDIR /source
COPY . .
RUN dotnet restore "SimpleApi.csproj" --disable-parallel
RUN dotnet publish "SimpleApi.csproj" -c release -o /app --no-restore

FROM --platform=linux/amd64 mcr.microsoft.com/dotnet/aspnet:6.0-focal
WORKDIR /app
COPY --from=build /app ./

EXPOSE 5001

ENTRYPOINT [ "dotnet", "SimpleApi.dll" ]

