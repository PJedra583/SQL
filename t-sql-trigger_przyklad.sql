CREATE TRIGGER t_example
ON Emp
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	-- CIAŁO WYZWALACZA
	-- inserted
	-- deleted

	/*
	UPDATE Emp SET Ename='Kowalski' WHERE Empno = 1;

	deleted
		Empno	Ename	Salary
		  1		 Nowak	 1000

	inserted
		Empno	Ename	Salary
		  1	   Kowalski	 1000
	*/

	-- Nie mozna usuwac pracownikow ktorzy zarabiaja wiecej niz 0
	IF EXISTS (SELECT 1
			   FROM inserted i RIGHT JOIN deleted d ON i.IdEmp=d.IdEmp
			   WHERE i.IdEmp IS NULL AND d.Salary > 0
			   )
				BEGIN
					RAISERROR('Nie mozna usuwac pracownikow ktorzy zarabiaja wiecej niz 0', 15, 1);
					ROLLBACK;
				END;
END;