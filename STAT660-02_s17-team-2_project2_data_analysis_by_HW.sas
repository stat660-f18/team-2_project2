*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding the effectness of a direct marketing campaigns of a 
Portuguese banking institution.

Dataset Name: bank_analysis created in external file
STAT660-01_f18-team-2_project2_data_preparation.sas, which is assumed to be in 
the same directory as this file.

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT660-01_f18-team-2_project2_data_preparation.sas'
;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Who were the clients of this bank?'
;

title2
'Rationale: This would help to identify the client of this bank, helping to understand who would be the target clients.'
;

footnote1
'Bank user demographic data such as age,job,marital,education,housing and loan are used to draw a whole picture of bank users.'
;

footnote2
'The average age of the bank users are 40 years old while almost half of them are from 28-38 years. Sixty percent of them are married and most of them do not have a loan.'

;

footnote3
'Based on the results, almost half of the bank users are admin and blue-collar.Besides, there are sixteen percent of them are techinician.'

;

footnote4
'Thiry percent of the users have a university degree while twenty-three percent are in high school degree.'

;

footnote5
'According to the result, half of them have a house while almost another half do not.'

;

*
Note: This is essentially trying to take a look at the users variables age,job,marital,education,housing and loan in 
the original bank_subscriber and bank_nonsubscriber datasets.

Methodology: Used proc freq to find the frequency of custmoer demographic
data, using the result to draw a picture of the customers of the bank.

Limitations: Since there are limited demographic variables in the dataset,
it would be better to include more attributes.

Follow-up Steps: Add more client demographic data into the data set or combine
with other data results of bank clients analysis.
;


%let TopN = 10;
proc freq 
    data=bank_analysis ORDER=FREQ
    ;
    table 
        age_range job marital education housing loan
    / maxlevels=&TopN Plots=FreqPlot(orient=horizontal scale=percent)
    ; 
run;


proc means 
    data =bank_analysis 
     mean median maxdec=2
     ;
     var 
        age
     ;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Would the age of bank users affect the campaign result?'

;

title2
'Rationale: Based on the analysis before, we noticed that the average age of the bank users are 40 years. This would help to find out what's the relationship between users'age and campaign result which could help to improve the campain performance.'

;

footnote1
'A logistic regression model was built to check how the age of users affect their decision of subscription.'

;

footnote2
'As user age increase, it is more likely that the campaign would be successful but the probability is relatively small.'

footnote3
'Based on the result, a small pvalue indicate that user age did affect their final decisions in the campaign even though the affectness is relatively small.'

;

*
Note: This compares the columns of age attributes to the outcome of subscription 
colume y in data_subscriber and data_nonsubscriber datasets.

Methodology: A logistic regression model is used to find out the relationship. 

Limitations:Since user age is only one of the social and economic context 
attributes.This analysis result may not be enough to undersatand how would the 
social and economic context affect the marketing campaign.

Follow-up Steps:Include more user attributes in the model.
;

proc logistic 
    data = bank_analysis
    ;
    model y (event = 'yes')= age
    ;
run;


run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;


title1
'Research Question:Is the consumer confidence related to the campaign result?'
;

title2
'Rationale: This would help understand how did social economic affect the marketing campaign result.'
;

footnote1
'A logistic regression was built to check the relationship between outcome of the previous marketing campaign and the outcome of this marketing campaign.'

;

footnote2
'The results tells us if the outcome of previous marketing campaign was success, the outcome of this marketing is more likely to be success.'

;

footnote3
'There is a small pvalue in the analysis result which tells us that this relationship is significant in reality.'

;


*

Note: Note: This compares the column ‘y’ from bank_nonsubscriber, bank_subscriber 
and the column ‘consumer confidence’ from bank_se.

Methodology: Use PROC logistic to run the logistic regression to find out the
exact relationship and whether this is significant in reality.

Limitations: There are many'nonexistent' values in the data set.
This will effect the accurace of the result because of the poor data quality.

Follow-up Steps: Find out a propriate value instead of using 'nonexistent' value
;

proc logistic
        data=bank_analysis
    ;
    class
        poutcome
    ;
    model
        y (event ='yes')= poutcome
    ;   
run;

title;
footnote;




