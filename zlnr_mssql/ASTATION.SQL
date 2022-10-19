if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[arrivestation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[arrivestation]
GO

CREATE TABLE [dbo].[arrivestation] (
	[StationID] [int] IDENTITY (1001, 1) NOT NULL ,
	[Jan] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[ArriveStation] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

