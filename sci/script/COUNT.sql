USE [SCI]
GO
/****** Object:  Table [dbo].[COUNT]    Script Date: 11/04/2007 14:05:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[COUNT](
	[SISTEMA] [varchar](50) NULL,
	[REFERRER] [varchar](50) NULL,
	[AGENT] [varchar](250) NULL,
	[LOCATION] [varchar](150) NULL,
	[IP] [varchar](50) NULL,
	[HOSTNAME] [varchar](50) NULL,
	[OS] [nvarchar](50) NULL,
	[USERDATE] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF