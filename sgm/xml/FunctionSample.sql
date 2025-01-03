USE [SCI]
GO
/****** Object:  UserDefinedFunction [dbo].[SimpleDecrypt]    Script Date: 08/10/2007 12:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[EquipoPrincipal]
(@string char(15))
RETURNS char(15)
AS
BEGIN
DECLARE @output char(15)
DECLARE @Codigo char(15)
DECLARE @i int, @l int, @c int
SET @i = 0
SET @l = 1
SET @output = ''

BEGIN
Declare TmpCur Cursor For
SELECT CODIGO FROM EQUIPOS WHERE COD_EQUIPO_PADRE = @string
Open TmpCur
Fetch Next From TmpCur
Into @Codigo
SET @output = @Codigo
END
RETURN @output
END