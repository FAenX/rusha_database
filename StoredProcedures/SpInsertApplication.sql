CREATE PROCEDURE [dbo].[SpInsertApplication]
  @ApplicationName NVARCHAR(255),
  @LocalGitRepo NVARCHAR(255),
  @jsonOutput NVARCHAR(MAX) OUTPUT
AS
BEGIN
  SET NOCOUNT ON;


  INSERT INTO [dbo].[Applications] (ApplicationName, LocalGitRepo)
  VALUES (@ApplicationName, @LocalGitRepo);

  -- insert into new_nginx_conf_queue (project_id)  
  IF SCOPE_IDENTITY() IS NOT NULL
  BEGIN
    INSERT INTO [dbo].[NginxConfCreateQueue] (ApplicationId)
    VALUES (SCOPE_IDENTITY());
  END
  
  
  SET @jsonOutput = JSON_QUERY((
    SELECT 
      a.Id as id,
      a.ApplicationName as applicationName,
      a.LocalGitRepo as localGitRepo,
      a.RequestedAt as requestedAt,
      a.GitCreatedAt as gitCreatedAt,
      a.NginxConfCreatedAt as nginxConfCreatedAt,
      a.ApplicationUpdatedAt as applicationUpdatedAt

    FROM Applications a WHERE Id = SCOPE_IDENTITY()
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER, INCLUDE_NULL_VALUES    
    ));
  RETURN 0;


END
GO

/**
unit test

begin transaction

declare @ApplicationName NVARCHAR(255) = 'test-sproject_3_2__2_2_2';
declare @LocalGitRepo NVARCHAR(255) = 'C:\test\project';
declare @jsonOutput NVARCHAR(MAX);

exec dbo.sp_insert_application @ApplicationName, @LocalGitRepo, @jsonOutput OUTPUT;

SELECT @jsonOutput;

rollback transaction


*/
