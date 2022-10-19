CREATE TABLE [dbo].[Applications]
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    ApplicationName nvarchar(255) NOT NULL,
    LocalGitRepo NVARCHAR(255) NOT NULL,
    RequestedAt datetime default getdate(),
    GitCreatedAt datetime default getdate(),
    NginxConfCreatedAt datetime,
    ApplicationUpdatedAt datetime,
    

    CONSTRAINT applications_application_name_uindex UNIQUE (ApplicationName)
);

