USE SH_MyBase;
SELECT ????????????.????????_????????????, ?????.???_????????????, ????????????.??????????
      From ???????????? INNER JOIN ????? On ????????????.????????_???????????? = ?????.???_????????????
	  Where ????????????.?????????? between 7 and 14


SELECT ????????????.????_???????????, ?????.???_????????????,
      Case 
	  When (????????????.?????????? between 1 and 5) then '<=5'
	  When (????????????.?????????? between 6 and 10) then '>=5'
	  else '????? ?????'
	  end [??????_??????????]
	  From ???????????? INNER JOIN ????? On ????????????.????????_???????????? = ?????.???_????????????
	  ORDER BY 
	  ( Case 
	        When (????????????.?????????? between 6 and 10) then 2
			When (????????????.?????????? between 1 and 5) then 3
			else 1
		end
	  )

SELECT isnull(?????.???_????????????, '!!!') [????], ????????????.??????????
      From ???????????? LEFT OUTER JOIN ????? 
	  On ????????????.????????_???????????? = ?????.???_????????????

SELECT isnull(?????.???_????????????, '!!!') [????], ????????????.??????????
      From ???????????? RIGHT OUTER JOIN ????? 
	  On ????????????.????????_???????????? = ?????.???_????????????

SELECT * From ????? FULL OUTER JOIN ???????????? 
      On ?????.???_???????????? = ????????????.????????_????????????
	  ORDER BY ???_????????????, ????????_????????????

SELECT * From ????? FULL OUTER JOIN ???????????? 
      On ?????.???_???????????? = ????????????.????????_????????????
	  Where ?????.???_???????????? is not null

SELECT * From ????? FULL OUTER JOIN ???????????? 
      On ?????.???_???????????? = ????????????.????????_????????????
	  Where ????????????.????????_???????????? is not null

SELECT ????????????.????????_????????????, ?????.???_????????????, ????????????.??????????
      From ???????????? CROSS JOIN ????? 
	  Where ????????????.????????_???????????? = ?????.???_????????????