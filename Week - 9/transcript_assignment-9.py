import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password= "",
  database="week09"
)

mycursor = mydb.cursor()

import sys

n = len(sys.argv)

rollnumber = sys.argv[1]

print("Indian Institute of Technology Guwahati")
print("\n")

print("Programme Duration: 4 years                                Semesters:Eight(8)")
print("\n")

mycursor.execute("SELECT * FROM student18 WHERE roll_number = %s", (rollnumber,))
nameofstu = mycursor.fetchone()
nameofstu = nameofstu[0]
print("Name: " + nameofstu + "                                 Roll Number: " + rollnumber)
print("\n")
print("Semester\tCourse\t\tCourseName\t\t\t\t\t\tCr")

mycursor.execute("SELECT c.semester, c.cid , c.name, g.letter_grade FROM student18 s \
JOIN grade18 g ON g.roll_number = s.roll_number \
JOIN course18 c ON c.cid = g.cid \
WHERE s.roll_number = %s \
ORDER BY c.semester;" , (rollnumber,))

data = mycursor.fetchall()
start = 1
print("\n")
for row in data:
    if(row[0] == start):
      print(str(row[0])+ "\t\t" + row[1].ljust(16,' ') + row[2].ljust(50,' ') + "\t" + row[3])
    else:
      start = start + 1
      print("\n")
      print(str(row[0])+ "\t\t" + row[1].ljust(16,' ') + row[2].ljust(50,' ') + "\t" + row[3])

print("\n")

for sem in range(1,9):
  mycursor.execute("SELECT sum(cou.c * CASE letter_grade WHEN 'AA' then 10 WHEN 'AB' then 9 WHEN \
              'BB' then 8 WHEN 'BC' then 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) as creds, \
              sum(cou.c) as total FROM grade18 g JOIN course18 cou ON g.cid = cou.cid \
              WHERE cou.semester = " + str(sem) +  " and roll_number = " + str(rollnumber))
  result = mycursor.fetchall()
  received_credits = int(result[0][0])
  total_credits = int(result[0][1])
  unrounded_spi = received_credits/total_credits
  rounded_spi = round(unrounded_spi,2)
  print("Semester: " + str(sem) + "  SPI: " + str(rounded_spi))

mycursor.execute("SELECT sum(cou.c * CASE letter_grade WHEN 'AA' then 10 WHEN 'AB' then 9 WHEN \
              'BB' then 8 WHEN 'BC' then 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) as creds, \
              sum(cou.c) as total FROM grade18 g JOIN course18 cou ON g.cid = cou.cid \
              WHERE roll_number = " + str(rollnumber))
result = mycursor.fetchall()
received_credits = int(result[0][0])
total_credits = int(result[0][1])
unrounded_CPI = received_credits/total_credits
rounded_CPI = round(unrounded_CPI,2)
print("CPI: " + str(rounded_CPI))
print("\n")


print("CORE COURSES\n")
for sem in range(1,9):
  mycursor.execute("SELECT cid \
                  FROM curriculum \
                  WHERE number = " + str(sem) + " and (cid not LIKE 'HS101' AND cid NOT LIKE 'SA%' AND cid NOT LIKE 'HS200' AND cid NOT LIKE 'HS1%' AND cid NOT LIKE '%M') \
                  EXCEPT \
                  SELECT g.cid \
                  FROM student18 s \
                  JOIN grade18 g ON g.roll_number = s.roll_number \
                  JOIN course18 c on c.cid = g.cid \
                  WHERE g.roll_number = " + rollnumber + " and c.semester = " + str(sem)) 
  missed_courses = mycursor.fetchall()
  if(missed_courses):
    # print("Core courses not taken by the student in Semester "+ str(sem) )
    # i = 0
    # for courses in missed_courses:
    #   print(missed_courses[i][0])
    #   i = i + 1
    print("No, the student didn't take all the core courses in the Semester " + str(sem))
    print("\n")
  else:
    print("Yes, the student took all the core courses in Semester " + str(sem))
    print("\n")

print("ELECTIVE COURSES\n")
for sem in range(1,9):
  mycursor.execute("SELECT cid \
                  FROM curriculum \
                  WHERE number = " + str(sem) + " and (cid LIKE 'CS5%' OR cid LIKE 'CS6%' OR cid LIKE 'CS7%' OR cid LIKE 'CSXXX') \
                  EXCEPT \
                  SELECT g.cid \
                  FROM student18 s \
                  JOIN grade18 g ON g.roll_number = s.roll_number \
                  JOIN course18 c on c.cid = g.cid \
                  WHERE g.roll_number = " + rollnumber + " and c.semester = " + str(sem)) 
  missed_courses = mycursor.fetchall()
  if(missed_courses):
    # print("Core courses not taken by the student in Semester "+ str(sem) )
    # i = 0
    # for courses in missed_courses:
    #   print(missed_courses[i][0])
    #   i = i + 1
    print("No, the student didn't take all the elective courses in the Semester" + str(sem))
    print("\n")
  else:
    print("Yes, the student took all the elective courses in Semester" + str(sem))
    print("\n")

print("MINOR COURSES\n")
for sem in range(1,9):
  mycursor.execute("SELECT cid \
                  FROM curriculum \
                  WHERE number = " + str(sem) + " and (cid LIKE '%M') \
                  EXCEPT \
                  SELECT g.cid \
                  FROM student18 s \
                  JOIN grade18 g ON g.roll_number = s.roll_number \
                  JOIN course18 c on c.cid = g.cid \
                  WHERE g.roll_number = " + rollnumber + " and c.semester = " + str(sem)) 
  missed_courses = mycursor.fetchall()
  if(missed_courses):
    # print("Core courses not taken by the student in Semester "+ str(sem) )
    # i = 0
    # for courses in missed_courses:
    #   print(missed_courses[i][0])
    #   i = i + 1
    print("No, the student didn't take all the minor courses in the Semester " + str(sem))
    print("\n")
  else:
    print("Yes, the student took all the minor courses in Semester " + str(sem))
    print("\n")

print("OPEN ELECTIVE COURSES\n")
for sem in range(1,9):
  mycursor.execute("SELECT cid \
                  FROM curriculum \
                  WHERE number = " + str(sem) + " and (cid LIKE 'OE%') \
                  EXCEPT \
                  SELECT g.cid \
                  FROM student18 s \
                  JOIN grade18 g ON g.roll_number = s.roll_number \
                  JOIN course18 c on c.cid = g.cid \
                  WHERE g.roll_number = " + rollnumber + " and c.semester = " + str(sem)) 
  missed_courses = mycursor.fetchall()
  if(missed_courses):
    # print("Core courses not taken by the student in Semester "+ str(sem) )
    # i = 0
    # for courses in missed_courses:
    #   print(missed_courses[i][0])
    #   i = i + 1
    print("No, the student didn't take all the open elective courses in the Semester " + str(sem))
    print("\n")
  else:
    print("Yes, the student took all the open elective courses in Semester" + str(sem))
    print("\n")

print("HSS COURSES\n")
for sem in range(1,9):
  mycursor.execute("SELECT cid \
  FROM curriculum \
  WHERE number = " + str(sem) + " and (cid LIKE 'HS%') \
  EXCEPT \
  SELECT g.cid  \
  FROM student18 s \
  JOIN grade18 g ON g.roll_number = s.roll_number \
  JOIN course18 c on c.cid = g.cid \
  WHERE g.roll_number = " + rollnumber + " and c.semester = " + str(sem)) 
  missed_courses = mycursor.fetchall() 
  if(missed_courses):
    # print("Core courses not taken by the student in Semester "+ str(sem) )
    # i = 0
    # for courses in missed_courses:
    #   print(missed_courses[i][0])
    #   i = i + 1
    print("No, the student didn't take all the SA courses in the Semester " + str(sem))
    print("\n")
  else:
    print("Yes, the student took all the SA courses in Semester " + str(sem))
    print("\n")


print("SA COURSES\n")
for sem in range(1,9):
  mycursor.execute("SELECT cid \
  FROM curriculum \
  WHERE number = " + str(sem) + " and (cid LIKE 'SA%') \
  EXCEPT \
  SELECT g.cid  \
  FROM student18 s \
  JOIN grade18 g ON g.roll_number = s.roll_number \
  JOIN course18 c on c.cid = g.cid \
  WHERE g.roll_number = " + rollnumber + " and c.semester = " + str(sem)) 
  missed_courses = mycursor.fetchall() 
  if(missed_courses):
    # print("Core courses not taken by the student in Semester "+ str(sem) )
    # i = 0
    # for courses in missed_courses:
    #   print(missed_courses[i][0])
    #   i = i + 1
    print("No, the student didn't take all the SA courses in the Semester " + str(sem))
    print("\n")
  else:
    print("Yes, the student took all the SA courses in Semester " + str(sem))
    print("\n")


print("FAILED COURSES\n")
for sem in range(1,9):
  mycursor.execute("select cid from student18 s join grade18 g on g.roll_number = s.roll_number where g.letter_grade like 'F' ") 
  missed_courses = mycursor.fetchall() 
  if(missed_courses):
    # print("Core courses not taken by the student in Semester "+ str(sem) )
    # i = 0
    # for courses in missed_courses:
    #   print(missed_courses[i][0])
    #   i = i + 1
    print("No, the student didn't fail in the Semester " + str(sem))
    print("\n")
  else:
    print("Yes, the student has failed in some courses in Semester " + str(sem))
    print("\n")

print("FAILED SA COURSES\n")
for sem in range(1,9):
  mycursor.execute("select cid from student18 s join grade18 g on g.roll_number = s.roll_number where g.letter_grade like 'F' AND g.cid like 'SA%'") 
  missed_courses = mycursor.fetchall() 
  if(missed_courses):
    # print("Core courses not taken by the student in Semester "+ str(sem) )
    # i = 0
    # for courses in missed_courses:
    #   print(missed_courses[i][0])
    #   i = i + 1
    print("No, the student didn't pass in all the SA courses in the Semester " + str(sem))
    print("\n")
  else:
    print("Yes, the student has passed in all SA courses in Semester " + str(sem))
    print("\n")


# If any set of courses is empty, I've given output as YES since there were no courses and it means he/she has taken all the courses.

# Indian Institute of Technology Guwahati


# Programme Duration: 4 years                                Semesters:Eight(8)


# Name: TEJAS PRASHANT KHAIRNAR                                 Roll Number: 180101081


# Semester	Course		CourseName						Cr


# 1		CH101           Chemistry                                         	AB
# 1		MA101           Mathematics-1                                     	AB
# 1		HS100           English Communication                             	BC
# 1		EE101           Basic Electronics                                 	DD
# 1		ME111           Engineering Drawing                               	AB
# 1		PH101           Physics-1                                         	BB
# 1		PH110           Physics Lab/ME110 Workshop                        	BC
# 1		CH110           Chemistry Lab                                     	CC


# 2		ME110           Workshop/PH110 Physics Lab                        	CD
# 2		MA102           Mathematics-2                                     	CD
# 2		CS110           Computing Lab                                     	BB
# 2		PH102           Physics-2                                         	CD
# 2		EE110           Basic Electronics Laboratory                      	CC
# 2		CS101           Introduction to Computing                         	BB
# 2		BT101           Introductory Biology                              	AB
# 2		SA101           Students Activity Course-1                        	CD
# 2		ME101           Engineering Mechanics                             	BB


# 3		MA222           Elementary Number Theory and Algebra              	DD
# 3		CS201           Discrete Mathematics                              	CC
# 3		CS203           Algorithms and Data Structures                    	CC
# 3		SA201           Students Activity Course-2                        	BC
# 3		MA225           Probability Theory and Random Processes           	CC
# 3		XX103M          Minor-1                                           	DD
# 3		CS242           System Software Lab                               	DD
# 3		CS221           Digital Design                                    	BB
# 3		CS204           Algorithms and Data Structures Lab                	CC


# 4		CS205           Formal Languages Automata Theory and Computation  	BB
# 4		HS101           HSS1-1                                            	CD
# 4		SA301           Students Activity Course-3                        	BC
# 4		XX104M          Minor-2                                           	CC
# 4		CS246           Database Management Systems Lab                   	BB
# 4		CS245           Database Management Systems                       	BC
# 4		CS224           Hardware Lab                                      	AA
# 4		CS223           Computer Architecture and Organization            	BB
# 4		CS207           Design and Analysis of Algorithms                 	CD


# 5		MA321           Optimization                                      	BB
# 5		SA401           Students Activity Course-4                        	CC
# 5		XX105M          Minor-3                                           	AA
# 5		CS341           Computer Networks                                 	BB
# 5		HS102           HSS1-2                                            	AB
# 5		CS501           Departmental Elective 5.1                         	BB
# 5		CS342           Computer Networks Lab                             	BC
# 5		CS343           Operating Systems                                 	AA
# 5		CS344           Operating Systems Lab                             	BB


# 6		CS405           Departmental Elective Lab 6.3                     	AB
# 6		CS404           Departmental Elective 6.2                         	AA
# 6		CS403           Departmental Elective 6.1                         	DD
# 6		XX101M          Minor-4                                           	AA
# 6		CS345           Software Engineering                              	AA
# 6		CS346           Software Engineering Lab                          	CD
# 6		CS348           Implementation of Programming Languages Lab       	CC
# 6		CS361           Machine Learning                                  	DD


# 7		HS201           HSS-2-1                                           	CC
# 7		XX102M          Minor 5                                           	AA
# 7		CS401           Elective 7.2                                      	AA
# 7		OE102           Open Elective 2/CS101 Elective 7.1                	CD
# 7		OE101           Open Elective 1                                   	CD
# 7		CS498           BTP Phase - 1                                     	BB


# 8		CS402           Elective 8.1                                      	CD
# 8		OE202           Open Elective 4                                   	BC
# 8		OE201           Open Elective 3                                   	BB
# 8		CS499           BTP Phase - 2                                     	AA
# 8		HS202           HSS-2-2                                           	CC


# Semester: 1  SPI: 7.58
# Semester: 2  SPI: 6.81
# Semester: 3  SPI: 5.54
# Semester: 4  SPI: 7.09
# Semester: 5  SPI: 8.59
# Semester: 6  SPI: 7.21
# Semester: 7  SPI: 7.43
# Semester: 8  SPI: 7.67
# CPI: 7.21


# CORE COURSES

# No, the student didn't take all the core courses in the Semester 1


# No, the student didn't take all the core courses in the Semester 2


# Yes, the student took all the core courses in Semester 3


# Yes, the student took all the core courses in Semester 4


# No, the student didn't take all the core courses in the Semester 5


# No, the student didn't take all the core courses in the Semester 6


# No, the student didn't take all the core courses in the Semester 7


# No, the student didn't take all the core courses in the Semester 8


# ELECTIVE COURSES

# Yes, the student took all the elective courses in Semester1


# Yes, the student took all the elective courses in Semester2


# Yes, the student took all the elective courses in Semester3


# Yes, the student took all the elective courses in Semester4


# No, the student didn't take all the elective courses in the Semester5


# No, the student didn't take all the elective courses in the Semester6


# No, the student didn't take all the elective courses in the Semester7


# No, the student didn't take all the elective courses in the Semester8


# MINOR COURSES

# Yes, the student took all the minor courses in Semester 1


# Yes, the student took all the minor courses in Semester 2


# No, the student didn't take all the minor courses in the Semester 3


# No, the student didn't take all the minor courses in the Semester 4


# No, the student didn't take all the minor courses in the Semester 5


# No, the student didn't take all the minor courses in the Semester 6


# No, the student didn't take all the minor courses in the Semester 7


# Yes, the student took all the minor courses in Semester 8


# OPEN ELECTIVE COURSES

# Yes, the student took all the open elective courses in Semester1


# Yes, the student took all the open elective courses in Semester2


# Yes, the student took all the open elective courses in Semester3


# Yes, the student took all the open elective courses in Semester4


# Yes, the student took all the open elective courses in Semester5


# Yes, the student took all the open elective courses in Semester6


# No, the student didn't take all the open elective courses in the Semester 7


# No, the student didn't take all the open elective courses in the Semester 8


# HSS COURSES

# No, the student didn't take all the SA courses in the Semester 1


# Yes, the student took all the SA courses in Semester 2


# No, the student didn't take all the SA courses in the Semester 3


# No, the student didn't take all the SA courses in the Semester 4


# No, the student didn't take all the SA courses in the Semester 5


# Yes, the student took all the SA courses in Semester 6


# No, the student didn't take all the SA courses in the Semester 7


# No, the student didn't take all the SA courses in the Semester 8


# SA COURSES

# Yes, the student took all the SA courses in Semester 1


# No, the student didn't take all the SA courses in the Semester 2


# No, the student didn't take all the SA courses in the Semester 3


# No, the student didn't take all the SA courses in the Semester 4


# No, the student didn't take all the SA courses in the Semester 5


# Yes, the student took all the SA courses in Semester 6


# Yes, the student took all the SA courses in Semester 7


# Yes, the student took all the SA courses in Semester 8


# FAILED COURSES

# Yes, the student has failed in some courses in Semester 1


# Yes, the student has failed in some courses in Semester 2


# Yes, the student has failed in some courses in Semester 3


# Yes, the student has failed in some courses in Semester 4


# Yes, the student has failed in some courses in Semester 5


# Yes, the student has failed in some courses in Semester 6


# Yes, the student has failed in some courses in Semester 7


# Yes, the student has failed in some courses in Semester 8


# FAILED SA COURSES

# Yes, the student has passed in all SA courses in Semester 1


# Yes, the student has passed in all SA courses in Semester 2


# Yes, the student has passed in all SA courses in Semester 3


# Yes, the student has passed in all SA courses in Semester 4


# Yes, the student has passed in all SA courses in Semester 5


# Yes, the student has passed in all SA courses in Semester 6


# Yes, the student has passed in all SA courses in Semester 7


# Yes, the student has passed in all SA courses in Semester 8

