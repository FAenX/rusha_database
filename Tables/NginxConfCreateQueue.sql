CREATE TABLE [dbo].[NginxConfCreateQueue]
(
  [Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  [ApplicationId] INT NOT NULL,
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
  [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
  [Status] NVARCHAR(255) NOT NULL DEFAULT 'pending',
  [NginxConf] NVARCHAR(MAX),
  [NginxConfCreatedAt] DATETIME NULL,

  FOREIGN KEY (ApplicationId) REFERENCES [dbo].[Applications] (Id)

)

GO

-- index: new_nginx_conf_queue_project_id_index     
CREATE INDEX [new_nginx_conf_queue_project_id_index] 
ON [dbo].[NginxConfCreateQueue] ([ApplicationId])