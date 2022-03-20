#build container
FROM mcr.microsoft.com/dotnet/sdk:2.1 as build

#install unzip for Cake
RUN apt-get update
RUN apt-get install -y unzip

WORKDIR /build
COPY . .
RUN chmod u+x /usr/local/bin/build.sh
RUN ./build.sh

#runtime container
FROM mcr.microsoft.com/dotnet/runtime:2.1

COPY --from=build /build/publish /app
WORKDIR /app

EXPOSE 5000

ENTRYPOINT ["dotnet", "Conduit.dll"]
