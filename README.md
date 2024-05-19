# ETL-project
ETL project repository

# Description
This is the repository for the group project of ETL Data Warehousing class at DSTI.

# Files
The repository contains the following files
  - Source data files
  - SQL queries for the tables creation
  - STA, ODS, DWH packages
  - Project Report

# Guidelines for the reproduction
In order to run the project, please follow these steps:
  - Install VisualStudio Community 17.9.7 or higher, with SSDT (SQL Server Data Tools) package.
  - Add SSIS extension to VisualStudio
  - Create a local SQL server, and use an alias called "ServiceSpot" for the server (instructions in https://www.youtube.com/watch?v=PaRFj-uzLhc&ab_channel=AllTech)
  - Create 4 databases in SQL server: SS_ADM, SS_STA, SS_ODS, SS_STA
  - Clone the repository (preferably from VisualStudio)
  - Modify 2 packages: ProjectParams, and STA_Data (in FELC container), both to contain the paths to the csv source data files (by default, they are set to Administrator folder)
  - Run the ETL-Pipeline package. It will create all the tables with T-SQL, and launch all the STA+ODS+DWH packages

