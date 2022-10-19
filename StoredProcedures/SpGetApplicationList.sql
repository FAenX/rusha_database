CREATE PROCEDURE [dbo].[SpGetApplicationList]
  @jsonOutput NVARCHAR(MAX) OUTPUT
AS
BEGIN
  SET NOCOUNT ON;
  SET @jsonOutput = JSON_QUERY((
    SELECT 
      a.Id,
      a.ApplicationName as applicationName,
      a.LocalGitRepo as localGitRepo,
      a.RequestedAt as requestedAt,
      a.GitCreatedAt as gitCreatedAt,
      a.NginxConfCreatedAt as nginxConfCreatedAt,
      a.ApplicationUpdatedAt as applicationUpdatedAt

    FROM Applications a
    ORDER BY a.Id DESC
    FOR JSON PATH
    ));
RETURN 0;
END

GO

/**
unit test

declare @jsonOutput NVARCHAR(max);

exec dbo.sp_get_application_list @jsonOutput OUTPUT;

SELECT @jsonOutput;

*/
