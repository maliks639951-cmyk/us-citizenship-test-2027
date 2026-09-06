import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const privacyUrl = 'https://sites.google.com/view/us-citizenship-2027/home';
const primaryBlue = Color(0xFF0A1931);
const accentBlue = Color(0xFF185ADB);
const goldColor = Color(0xFFFFD700);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const CitizenshipApp());
}

class Question {
  final int number;
  final String category;
  final String question;
  final String answer;
  final List<String> options;
  const Question({
    required this.number,
    required this.category,
    required this.question,
    required this.answer,
    required this.options,
  });
}

// ============ 128 QUESTIONS - OFFICIAL USCIS - CATEGORY WISE - ENGLISH ONLY ============
final List<Question> questions = [
  const Question(
    number: 1,
    category: 'American Government',
    question: 'What is the supreme law of the land?',
    answer: 'The Constitution',
    options: [
      'The Declaration of Independence',
      'The Constitution',
      'The Bill of Rights',
      'The Supreme Court',
    ],
  ),
  const Question(
    number: 2,
    category: 'American Government',
    question: 'What does the Constitution do?',
    answer: 'Sets up the government',
    options: [
      'Sets up the government',
      'Names the President',
      'Creates the states',
      'Declares war',
    ],
  ),
  const Question(
    number: 3,
    category: 'American Government',
    question:
        'The idea of self-government is in the first three words of the Constitution. What are these words?',
    answer: 'We the People',
    options: [
      'United States',
      'We the People',
      'In God We',
      'Freedom and Justice',
    ],
  ),
  const Question(
    number: 4,
    category: 'American Government',
    question: 'What is an amendment?',
    answer: 'A change or addition to the Constitution',
    options: [
      'A change or addition to the Constitution',
      'A new state',
      'A court decision',
      'A presidential order',
    ],
  ),
  const Question(
    number: 5,
    category: 'American Government',
    question: 'What do we call the first ten amendments to the Constitution?',
    answer: 'The Bill of Rights',
    options: [
      'The Bill of Rights',
      'The Federal Papers',
      'The Articles',
      'The Declaration',
    ],
  ),
  const Question(
    number: 6,
    category: 'American Government',
    question: 'What is one right or freedom from the First Amendment?',
    answer: 'Speech',
    options: ['Speech', 'Driving', 'Free housing', 'Free college'],
  ),
  const Question(
    number: 7,
    category: 'American Government',
    question: 'How many amendments does the Constitution have?',
    answer: '27',
    options: ['10', '27', '50', '100'],
  ),
  const Question(
    number: 8,
    category: 'American Government',
    question: 'What did the Declaration of Independence do?',
    answer: 'Declared our independence from Great Britain',
    options: [
      'Created Congress',
      'Declared our independence from Great Britain',
      'Created the Supreme Court',
      'Ended the Civil War',
    ],
  ),
  const Question(
    number: 9,
    category: 'American Government',
    question: 'What are two rights in the Declaration of Independence?',
    answer: 'Life and liberty',
    options: [
      'Life and liberty',
      'Housing and education',
      'Work and travel',
      'Food and healthcare',
    ],
  ),
  const Question(
    number: 10,
    category: 'American Government',
    question: 'What is freedom of religion?',
    answer: 'You can practice any religion, or not practice a religion',
    options: [
      'Only one religion is allowed',
      'You can practice any religion, or not practice a religion',
      'Religion is required',
      'Only government religion is allowed',
    ],
  ),
  const Question(
    number: 11,
    category: 'American Government',
    question: 'What is the economic system in the United States?',
    answer: 'Capitalist economy',
    options: [
      'Socialist economy',
      'Capitalist economy',
      'Monarchy',
      'Communist economy',
    ],
  ),
  const Question(
    number: 12,
    category: 'American Government',
    question: 'What is the rule of law?',
    answer: 'Everyone must follow the law',
    options: [
      'Only citizens follow the law',
      'Everyone must follow the law',
      'Only judges follow the law',
      'The President is above the law',
    ],
  ),
  const Question(
    number: 13,
    category: 'American Government',
    question: 'Name one branch or part of the government.',
    answer: 'Congress',
    options: ['Congress', 'The police', 'The military', 'The media'],
  ),
  const Question(
    number: 14,
    category: 'American Government',
    question: 'What stops one branch of government from becoming too powerful?',
    answer: 'Checks and balances',
    options: [
      'Checks and balances',
      'The military',
      'The states only',
      'The media',
    ],
  ),
  const Question(
    number: 15,
    category: 'American Government',
    question: 'Who is in charge of the executive branch?',
    answer: 'The President',
    options: [
      'The Speaker of the House',
      'The President',
      'The Chief Justice',
      'The Senate',
    ],
  ),
  const Question(
    number: 16,
    category: 'American Government',
    question: 'Who makes federal laws?',
    answer: 'Congress',
    options: [
      'The President alone',
      'Congress',
      'The Supreme Court',
      'State governors',
    ],
  ),
  const Question(
    number: 17,
    category: 'American Government',
    question: 'What are the two parts of the U.S. Congress?',
    answer: 'The Senate and House of Representatives',
    options: [
      'The Senate and House of Representatives',
      'The President and Senate',
      'The House and Supreme Court',
      'The Senate and Cabinet',
    ],
  ),
  const Question(
    number: 18,
    category: 'American Government',
    question: 'How many U.S. Senators are there?',
    answer: '100',
    options: ['50', '100', '435', '538'],
  ),
  const Question(
    number: 19,
    category: 'American Government',
    question: 'We elect a U.S. Senator for how many years?',
    answer: '6',
    options: ['2', '4', '6', '8'],
  ),
  const Question(
    number: 20,
    category: 'American Government',
    question: 'Who is one of your state’s U.S. Senators now?',
    answer: 'Answers vary by state',
    options: [
      'Answers vary by state',
      'The President',
      'The Chief Justice',
      'The Speaker',
    ],
  ),
  const Question(
    number: 21,
    category: 'American Government',
    question: 'The House of Representatives has how many voting members?',
    answer: '435',
    options: ['100', '435', '50', '538'],
  ),
  const Question(
    number: 22,
    category: 'American Government',
    question: 'We elect a U.S. Representative for how many years?',
    answer: '2',
    options: ['2', '4', '6', '8'],
  ),
  const Question(
    number: 23,
    category: 'American Government',
    question: 'Name your U.S. Representative.',
    answer: 'Answers vary by district',
    options: [
      'Answers vary by district',
      'The President',
      'The Vice President',
      'The Chief Justice',
    ],
  ),
  const Question(
    number: 24,
    category: 'American Government',
    question: 'Who does a U.S. Senator represent?',
    answer: 'All people of the state',
    options: [
      'All people of the state',
      'Only the governor',
      'Only Congress',
      'Only citizens of Washington',
    ],
  ),
  const Question(
    number: 25,
    category: 'American Government',
    question: 'Why do some states have more Representatives than other states?',
    answer: 'Because of the state’s population',
    options: [
      'Because of the state’s population',
      'Because they are older',
      'Because of their size only',
      'Because of their governors',
    ],
  ),
  const Question(
    number: 26,
    category: 'American Government',
    question: 'We elect a President for how many years?',
    answer: '4',
    options: ['2', '4', '6', '8'],
  ),
  const Question(
    number: 27,
    category: 'American Government',
    question: 'In what month do we vote for President?',
    answer: 'November',
    options: ['January', 'June', 'November', 'December'],
  ),
  const Question(
    number: 28,
    category: 'American Government',
    question: 'What is the name of the President of the United States now?',
    answer: 'The current President',
    options: [
      'The current President',
      'The Chief Justice',
      'The Speaker',
      'The Secretary of State',
    ],
  ),
  const Question(
    number: 29,
    category: 'American Government',
    question:
        'What is the name of the Vice President of the United States now?',
    answer: 'The current Vice President',
    options: [
      'The current Vice President',
      'The Speaker',
      'The Chief Justice',
      'The Secretary of State',
    ],
  ),
  const Question(
    number: 30,
    category: 'American Government',
    question: 'If the President can no longer serve, who becomes President?',
    answer: 'The Vice President',
    options: [
      'The Vice President',
      'The Speaker',
      'The Chief Justice',
      'The Secretary of State',
    ],
  ),
  const Question(
    number: 31,
    category: 'American Government',
    question:
        'If both the President and Vice President can no longer serve, who becomes President?',
    answer: 'The Speaker of the House',
    options: [
      'The Speaker of the House',
      'The Chief Justice',
      'The Senate',
      'The Secretary of State',
    ],
  ),
  const Question(
    number: 32,
    category: 'American Government',
    question: 'Who is the Commander in Chief of the military?',
    answer: 'The President',
    options: [
      'The President',
      'The Secretary of Defense',
      'Congress',
      'The Chief Justice',
    ],
  ),
  const Question(
    number: 33,
    category: 'American Government',
    question: 'Who signs bills to become laws?',
    answer: 'The President',
    options: [
      'The President',
      'The Senate',
      'The Supreme Court',
      'The Vice President',
    ],
  ),
  const Question(
    number: 34,
    category: 'American Government',
    question: 'Who vetoes bills?',
    answer: 'The President',
    options: ['The President', 'Congress', 'The Supreme Court', 'The states'],
  ),
  const Question(
    number: 35,
    category: 'American Government',
    question: 'What does the President’s Cabinet do?',
    answer: 'Advises the President',
    options: [
      'Advises the President',
      'Writes the Constitution',
      'Elects Congress',
      'Runs state governments',
    ],
  ),
  const Question(
    number: 36,
    category: 'American Government',
    question: 'What are two Cabinet-level positions?',
    answer: 'Secretary of State and Secretary of Defense',
    options: [
      'Secretary of State and Secretary of Defense',
      'Mayor and Governor',
      'Judge and Senator',
      'President and Vice President',
    ],
  ),
  const Question(
    number: 37,
    category: 'American Government',
    question: 'What does the judicial branch do?',
    answer: 'Reviews laws',
    options: [
      'Reviews laws',
      'Writes laws',
      'Commands the military',
      'Collects taxes',
    ],
  ),
  const Question(
    number: 38,
    category: 'American Government',
    question: 'What is the highest court in the United States?',
    answer: 'The Supreme Court',
    options: [
      'The Supreme Court',
      'The Senate',
      'The Federal Court',
      'The House',
    ],
  ),
  const Question(
    number: 39,
    category: 'American Government',
    question: 'How many justices are on the Supreme Court?',
    answer: '9',
    options: ['7', '9', '11', '13'],
  ),
  const Question(
    number: 40,
    category: 'American Government',
    question: 'Who is the Chief Justice of the United States now?',
    answer: 'The current Chief Justice',
    options: [
      'The current Chief Justice',
      'The President',
      'The Vice President',
      'The Speaker',
    ],
  ),
  const Question(
    number: 41,
    category: 'Rights and Responsibilities',
    question:
        'Under our Constitution, some powers belong to the federal government. What is one power of the federal government?',
    answer: 'To print money',
    options: [
      'To print money',
      'To issue driver licenses',
      'To provide local schools',
      'To set city parking rules',
    ],
  ),
  const Question(
    number: 42,
    category: 'Rights and Responsibilities',
    question:
        'Under our Constitution, some powers belong to the states. What is one power of the states?',
    answer: 'Provide schooling and education',
    options: [
      'Provide schooling and education',
      'Print money',
      'Declare war',
      'Make treaties',
    ],
  ),
  const Question(
    number: 43,
    category: 'Rights and Responsibilities',
    question: 'Who is the Governor of your state now?',
    answer: 'Answers vary by state',
    options: [
      'Answers vary by state',
      'The President',
      'The Chief Justice',
      'The Vice President',
    ],
  ),
  const Question(
    number: 44,
    category: 'Rights and Responsibilities',
    question: 'What is the capital of your state?',
    answer: 'Answers vary by state',
    options: [
      'Answers vary by state',
      'Washington, D.C.',
      'New York City',
      'Los Angeles',
    ],
  ),
  const Question(
    number: 45,
    category: 'Rights and Responsibilities',
    question: 'What are the two major political parties in the United States?',
    answer: 'Democratic and Republican',
    options: [
      'Democratic and Republican',
      'Liberal and Conservative',
      'Federal and State',
      'North and South',
    ],
  ),
  const Question(
    number: 46,
    category: 'Rights and Responsibilities',
    question: 'What is the political party of the President now?',
    answer: 'The current President’s party',
    options: [
      'The current President’s party',
      'Always Democratic',
      'Always Republican',
      'No party',
    ],
  ),
  const Question(
    number: 47,
    category: 'Rights and Responsibilities',
    question:
        'What is the name of the Speaker of the House of Representatives now?',
    answer: 'The current Speaker',
    options: [
      'The current Speaker',
      'The President',
      'The Vice President',
      'The Chief Justice',
    ],
  ),
  const Question(
    number: 48,
    category: 'Rights and Responsibilities',
    question:
        'There are four amendments to the Constitution about who can vote. Describe one.',
    answer: 'Citizens 18 and older can vote',
    options: [
      'Citizens 18 and older can vote',
      'Only property owners can vote',
      'Only men can vote',
      'Only senators can vote',
    ],
  ),
  const Question(
    number: 49,
    category: 'Rights and Responsibilities',
    question:
        'What is one responsibility that is only for United States citizens?',
    answer: 'Serve on a jury',
    options: ['Serve on a jury', 'Pay rent', 'Drive a car', 'Go to school'],
  ),
  const Question(
    number: 50,
    category: 'Rights and Responsibilities',
    question: 'Name one right only for United States citizens.',
    answer: 'Vote in a federal election',
    options: [
      'Vote in a federal election',
      'Freedom of speech',
      'Freedom of religion',
      'Right to a fair trial',
    ],
  ),
  const Question(
    number: 51,
    category: 'American History',
    question: 'What are two rights of everyone living in the United States?',
    answer: 'Freedom of speech and freedom of religion',
    options: [
      'Freedom of speech and freedom of religion',
      'Free housing and free food',
      'Free travel and free college',
      'Free healthcare and free housing',
    ],
  ),
  const Question(
    number: 52,
    category: 'American History',
    question:
        'What do we show loyalty to when we say the Pledge of Allegiance?',
    answer: 'The United States',
    options: [
      'The President',
      'The United States',
      'Congress',
      'The Supreme Court',
    ],
  ),
  const Question(
    number: 53,
    category: 'American History',
    question:
        'What is one promise you make when you become a United States citizen?',
    answer: 'Give up loyalty to other countries',
    options: [
      'Give up loyalty to other countries',
      'Become a senator',
      'Join the military',
      'Move to Washington',
    ],
  ),
  const Question(
    number: 54,
    category: 'American History',
    question: 'How old do citizens have to be to vote for President?',
    answer: '18 and older',
    options: ['16 and older', '18 and older', '21 and older', '25 and older'],
  ),
  const Question(
    number: 55,
    category: 'American History',
    question:
        'What are two ways that Americans can participate in their democracy?',
    answer: 'Vote and join a political party',
    options: [
      'Vote and join a political party',
      'Only pay taxes',
      'Only watch television',
      'Only serve in the military',
    ],
  ),
  const Question(
    number: 56,
    category: 'American History',
    question: 'When is the last day you can send in federal income tax forms?',
    answer: 'April 15',
    options: ['January 1', 'April 15', 'July 4', 'December 31'],
  ),
  const Question(
    number: 57,
    category: 'American History',
    question: 'When must all men register for the Selective Service?',
    answer: 'At age 18',
    options: ['At age 16', 'At age 18', 'At age 21', 'At age 25'],
  ),
  const Question(
    number: 58,
    category: 'American History',
    question: 'Who lived in America before the Europeans arrived?',
    answer: 'American Indians',
    options: [
      'American Indians',
      'Only Europeans',
      'Only Africans',
      'Only Asians',
    ],
  ),
  const Question(
    number: 59,
    category: 'American History',
    question: 'What group of people was taken to America and sold as slaves?',
    answer: 'Africans',
    options: ['Africans', 'Canadians', 'Australians', 'Europeans'],
  ),
  const Question(
    number: 60,
    category: 'American History',
    question: 'Why did the colonists fight the British?',
    answer: 'Because of high taxes and lack of self-government',
    options: [
      'Because of high taxes and lack of self-government',
      'Because Britain had no army',
      'Because of the weather',
      'Because they wanted a king',
    ],
  ),
  const Question(
    number: 61,
    category: 'American History',
    question: 'Who wrote the Declaration of Independence?',
    answer: 'Thomas Jefferson',
    options: [
      'Thomas Jefferson',
      'George Washington',
      'Abraham Lincoln',
      'Benjamin Franklin',
    ],
  ),
  const Question(
    number: 62,
    category: 'American History',
    question: 'When was the Declaration of Independence adopted?',
    answer: 'July 4, 1776',
    options: [
      'July 4, 1776',
      'July 4, 1787',
      'December 25, 1776',
      'November 11, 1776',
    ],
  ),
  const Question(
    number: 63,
    category: 'American History',
    question: 'There were 13 original states. Name three.',
    answer: 'New York, Virginia, and Pennsylvania',
    options: [
      'New York, Virginia, and Pennsylvania',
      'California, Texas, and Florida',
      'Alaska, Hawaii, and Oregon',
      'Nevada, Arizona, and Utah',
    ],
  ),
  const Question(
    number: 64,
    category: 'American History',
    question: 'What happened at the Constitutional Convention?',
    answer: 'The Constitution was written',
    options: [
      'The Constitution was written',
      'The Civil War began',
      'The Declaration was signed',
      'The President was elected',
    ],
  ),
  const Question(
    number: 65,
    category: 'American History',
    question: 'When was the Constitution written?',
    answer: '1787',
    options: ['1776', '1787', '1800', '1865'],
  ),
  const Question(
    number: 66,
    category: 'American History',
    question:
        'The Federalist Papers supported the passage of the U.S. Constitution. Name one of the writers.',
    answer: 'James Madison',
    options: [
      'James Madison',
      'Abraham Lincoln',
      'George Washington',
      'Martin Luther King Jr.',
    ],
  ),
  const Question(
    number: 67,
    category: 'American History',
    question: 'What is one thing Benjamin Franklin is famous for?',
    answer: 'U.S. diplomat',
    options: [
      'U.S. diplomat',
      'President',
      'Chief Justice',
      'Civil War general',
    ],
  ),
  const Question(
    number: 68,
    category: 'American History',
    question: 'Who is the “Father of Our Country”?',
    answer: 'George Washington',
    options: [
      'George Washington',
      'Thomas Jefferson',
      'John Adams',
      'Abraham Lincoln',
    ],
  ),
  const Question(
    number: 69,
    category: 'American History',
    question: 'Who was the first President of the United States?',
    answer: 'George Washington',
    options: [
      'George Washington',
      'Thomas Jefferson',
      'John Adams',
      'Abraham Lincoln',
    ],
  ),
  const Question(
    number: 70,
    category: 'American History',
    question: 'What territory did the United States buy from France in 1803?',
    answer: 'The Louisiana Territory',
    options: ['The Louisiana Territory', 'Florida', 'Alaska', 'Hawaii'],
  ),
  const Question(
    number: 71,
    category: 'American History',
    question: 'Name one war fought by the United States in the 1800s.',
    answer: 'Civil War',
    options: ['Civil War', 'World War I', 'World War II', 'Korean War'],
  ),
  const Question(
    number: 72,
    category: 'American History',
    question: 'Name the U.S. war between the North and the South.',
    answer: 'The Civil War',
    options: [
      'The Civil War',
      'The Revolutionary War',
      'World War I',
      'The War of 1812',
    ],
  ),
  const Question(
    number: 73,
    category: 'American History',
    question: 'Name one problem that led to the Civil War.',
    answer: 'Slavery',
    options: ['Slavery', 'Space travel', 'Immigration', 'The internet'],
  ),
  const Question(
    number: 74,
    category: 'American History',
    question: 'What was one important thing that Abraham Lincoln did?',
    answer: 'Freed the slaves',
    options: [
      'Freed the slaves',
      'Bought Alaska',
      'Wrote the Constitution',
      'Founded the Supreme Court',
    ],
  ),
  const Question(
    number: 75,
    category: 'American History',
    question: 'What did the Emancipation Proclamation do?',
    answer: 'Freed the slaves',
    options: [
      'Freed the slaves',
      'Created Congress',
      'Started the Revolutionary War',
      'Bought Louisiana',
    ],
  ),
  const Question(
    number: 76,
    category: 'American History',
    question: 'What did Susan B. Anthony do?',
    answer: 'Fought for women’s rights',
    options: [
      'Fought for women’s rights',
      'Was President',
      'Founded NASA',
      'Wrote the Constitution',
    ],
  ),
  const Question(
    number: 77,
    category: 'American History',
    question: 'Name one war fought by the United States in the 1900s.',
    answer: 'World War II',
    options: ['World War II', 'Civil War', 'Revolutionary War', 'War of 1812'],
  ),
  const Question(
    number: 78,
    category: 'American History',
    question: 'Who was President during World War I?',
    answer: 'Woodrow Wilson',
    options: [
      'Woodrow Wilson',
      'Franklin Roosevelt',
      'Harry Truman',
      'Theodore Roosevelt',
    ],
  ),
  const Question(
    number: 79,
    category: 'American History',
    question: 'Who was President during the Great Depression and World War II?',
    answer: 'Franklin Roosevelt',
    options: [
      'Franklin Roosevelt',
      'Woodrow Wilson',
      'Harry Truman',
      'John Kennedy',
    ],
  ),
  const Question(
    number: 80,
    category: 'American History',
    question: 'Who did the United States fight in World War II?',
    answer: 'Japan, Germany, and Italy',
    options: [
      'Japan, Germany, and Italy',
      'Canada and Mexico',
      'France and Spain',
      'Brazil and Argentina',
    ],
  ),
  const Question(
    number: 81,
    category: 'American History',
    question:
        'Before he was President, Eisenhower was a general. What war was he in?',
    answer: 'World War II',
    options: ['World War II', 'Civil War', 'World War I', 'Vietnam War'],
  ),
  const Question(
    number: 82,
    category: 'American History',
    question:
        'During the Cold War, what was the main concern of the United States?',
    answer: 'Communism',
    options: ['Communism', 'Tourism', 'Agriculture', 'Space weather'],
  ),
  const Question(
    number: 83,
    category: 'American History',
    question: 'What movement tried to end racial discrimination?',
    answer: 'Civil rights movement',
    options: [
      'Civil rights movement',
      'Tea Party',
      'Space movement',
      'Labor movement',
    ],
  ),
  const Question(
    number: 84,
    category: 'American History',
    question: 'What did Martin Luther King Jr. do?',
    answer: 'Fought for civil rights',
    options: [
      'Fought for civil rights',
      'Was President',
      'Founded the FBI',
      'Wrote the Constitution',
    ],
  ),
  const Question(
    number: 85,
    category: 'American History',
    question: 'Why did the United States enter the Vietnam War?',
    answer: 'To stop the spread of communism',
    options: [
      'To stop the spread of communism',
      'To buy land',
      'To fight Britain',
      'To build the Panama Canal',
    ],
  ),
  const Question(
    number: 86,
    category: 'American History',
    question: 'What major event happened on September 11, 2001?',
    answer: 'Terrorists attacked the United States',
    options: [
      'Terrorists attacked the United States',
      'The Constitution was written',
      'The Civil War ended',
      'The Declaration was signed',
    ],
  ),
  const Question(
    number: 87,
    category: 'American History',
    question: 'Name one American Indian tribe in the United States.',
    answer: 'Cherokee',
    options: ['Cherokee', 'Roman', 'Viking', 'Spartan'],
  ),
  const Question(
    number: 88,
    category: 'Geography',
    question: 'Name one of the two longest rivers in the United States.',
    answer: 'Missouri River',
    options: [
      'Missouri River',
      'Colorado River',
      'Hudson River',
      'Potomac River',
    ],
  ),
  const Question(
    number: 89,
    category: 'Geography',
    question: 'What ocean is on the West Coast of the United States?',
    answer: 'Pacific Ocean',
    options: [
      'Pacific Ocean',
      'Atlantic Ocean',
      'Indian Ocean',
      'Arctic Ocean',
    ],
  ),
  const Question(
    number: 90,
    category: 'Geography',
    question: 'What ocean is on the East Coast of the United States?',
    answer: 'Atlantic Ocean',
    options: [
      'Atlantic Ocean',
      'Pacific Ocean',
      'Indian Ocean',
      'Southern Ocean',
    ],
  ),
  const Question(
    number: 91,
    category: 'Geography',
    question: 'Name one U.S. territory.',
    answer: 'Puerto Rico',
    options: ['Puerto Rico', 'Canada', 'Mexico', 'Greenland'],
  ),
  const Question(
    number: 92,
    category: 'Geography',
    question: 'Name one state that borders Canada.',
    answer: 'New York',
    options: ['New York', 'Texas', 'Florida', 'Arizona'],
  ),
  const Question(
    number: 93,
    category: 'Geography',
    question: 'Name one state that borders Mexico.',
    answer: 'Texas',
    options: ['Texas', 'New York', 'Washington', 'Maine'],
  ),
  const Question(
    number: 94,
    category: 'Symbols',
    question: 'What is the capital of the United States?',
    answer: 'Washington, D.C.',
    options: ['Washington, D.C.', 'New York City', 'Boston', 'Philadelphia'],
  ),
  const Question(
    number: 95,
    category: 'Symbols',
    question: 'Where is the Statue of Liberty?',
    answer: 'New York Harbor',
    options: ['New York Harbor', 'Washington, D.C.', 'Los Angeles', 'Chicago'],
  ),
  const Question(
    number: 96,
    category: 'Symbols',
    question: 'Why does the flag have 13 stripes?',
    answer: 'Because there were 13 original colonies',
    options: [
      'Because there were 13 original colonies',
      'Because there are 13 states',
      'Because there are 13 presidents',
      'Because there are 13 amendments',
    ],
  ),
  const Question(
    number: 97,
    category: 'Symbols',
    question: 'Why does the flag have 50 stars?',
    answer: 'Because there are 50 states',
    options: [
      'Because there are 50 states',
      'Because there are 50 colonies',
      'Because there are 50 presidents',
      'Because there are 50 amendments',
    ],
  ),
  const Question(
    number: 98,
    category: 'Holidays',
    question: 'What is the name of the national anthem?',
    answer: 'The Star-Spangled Banner',
    options: [
      'The Star-Spangled Banner',
      'America the Beautiful',
      'God Bless America',
      'My Country, Tis of Thee',
    ],
  ),
  const Question(
    number: 99,
    category: 'Holidays',
    question: 'When do we celebrate Independence Day?',
    answer: 'July 4',
    options: ['July 4', 'December 25', 'November 11', 'January 1'],
  ),
  const Question(
    number: 100,
    category: 'Holidays',
    question: 'Name two national U.S. holidays.',
    answer: 'Independence Day and Thanksgiving',
    options: [
      'Independence Day and Thanksgiving',
      'Halloween and Valentine’s Day',
      'Easter and Halloween',
      'New Year’s Eve and Valentine’s Day',
    ],
  ),
  const Question(
    number: 101,
    category: 'American Government',
    question: 'Why does the President serve only two terms?',
    answer: 'Because of the 22nd Amendment',
    options: [
      'Because of the 22nd Amendment',
      'Because of tradition',
      'Supreme Court decided',
      'Congress rule',
    ],
  ),
  const Question(
    number: 102,
    category: 'American Government',
    question: 'Who has the power to declare war?',
    answer: 'Congress',
    options: ['Congress', 'President', 'Supreme Court', 'Vice President'],
  ),
  const Question(
    number: 103,
    category: 'American Government',
    question: 'What is the purpose of the 10th Amendment?',
    answer: 'States have powers not given to federal government',
    options: [
      'States have powers not given to federal government',
      'Federal controls all',
      'President controls states',
      'Courts control states',
    ],
  ),
  const Question(
    number: 104,
    category: 'American Government',
    question: 'What does the 19th Amendment do?',
    answer: 'Gives women the right to vote',
    options: [
      'Gives women the right to vote',
      'Ends slavery',
      'Citizens 18 can vote',
      'Bans alcohol',
    ],
  ),
  const Question(
    number: 105,
    category: 'American Government',
    question: 'What does the 13th Amendment do?',
    answer: 'Abolished slavery',
    options: [
      'Abolished slavery',
      'Women vote',
      'Voting age 18',
      'Free speech',
    ],
  ),
  const Question(
    number: 106,
    category: 'American Government',
    question: 'What does the 26th Amendment do?',
    answer: 'Citizens 18 and older can vote',
    options: [
      'Citizens 18 and older can vote',
      'Ends slavery',
      'Women vote',
      'Presidential terms',
    ],
  ),
  const Question(
    number: 107,
    category: 'American History',
    question: 'Name one American innovation.',
    answer: 'Light bulb',
    options: ['Light bulb', 'Pyramid', 'Colosseum', 'Eiffel Tower'],
  ),
  const Question(
    number: 108,
    category: 'American History',
    question: 'Why did the United States enter World War II?',
    answer: 'Because Japan attacked Pearl Harbor',
    options: [
      'Because Japan attacked Pearl Harbor',
      'Germany invaded US',
      'Italy attacked',
      'Britain asked',
    ],
  ),
  const Question(
    number: 109,
    category: 'American History',
    question: 'What did the civil rights movement do?',
    answer: 'Fought to end racial discrimination',
    options: [
      'Fought to end racial discrimination',
      'Tried to end war',
      'Built roads',
      'Created NASA',
    ],
  ),
  const Question(
    number: 110,
    category: 'Geography',
    question:
        'What major event happened on September 11, 2001, in the United States?',
    answer: 'Terrorists attacked the United States',
    options: [
      'Terrorists attacked the United States',
      'Moon landing',
      'Civil War ended',
      'WWII ended',
    ],
  ),
  const Question(
    number: 111,
    category: 'Geography',
    question: 'Name one of the two longest rivers in the United States.',
    answer: 'Mississippi River',
    options: [
      'Mississippi River',
      'Colorado River',
      'Amazon River',
      'Nile River',
    ],
  ),
  const Question(
    number: 112,
    category: 'Geography',
    question: 'What ocean is on the West Coast of the United States?',
    answer: 'Pacific Ocean',
    options: [
      'Pacific Ocean',
      'Atlantic Ocean',
      'Indian Ocean',
      'Arctic Ocean',
    ],
  ),
  const Question(
    number: 113,
    category: 'Geography',
    question: 'What ocean is on the East Coast of the United States?',
    answer: 'Atlantic Ocean',
    options: [
      'Atlantic Ocean',
      'Pacific Ocean',
      'Indian Ocean',
      'Arctic Ocean',
    ],
  ),
  const Question(
    number: 114,
    category: 'Geography',
    question: 'Name one U.S. territory.',
    answer: 'Guam',
    options: ['Guam', 'Canada', 'Mexico', 'Greenland'],
  ),
  const Question(
    number: 115,
    category: 'Geography',
    question: 'Name one state that borders Canada.',
    answer: 'Montana',
    options: ['Montana', 'Texas', 'Florida', 'Arizona'],
  ),
  const Question(
    number: 116,
    category: 'Geography',
    question: 'Name one state that borders Mexico.',
    answer: 'California',
    options: ['California', 'New York', 'Maine', 'Washington'],
  ),
  const Question(
    number: 117,
    category: 'Symbols',
    question: 'What is the capital of the United States?',
    answer: 'Washington, D.C.',
    options: ['Washington, D.C.', 'New York City', 'Boston', 'Philadelphia'],
  ),
  const Question(
    number: 118,
    category: 'Symbols',
    question: 'Where is the Statue of Liberty?',
    answer: 'New York Harbor',
    options: ['New York Harbor', 'Washington, D.C.', 'Los Angeles', 'Chicago'],
  ),
  const Question(
    number: 119,
    category: 'Symbols',
    question: 'Why does the flag have 13 stripes?',
    answer: 'Because there were 13 original colonies',
    options: [
      'Because there were 13 original colonies',
      'Because there are 13 states now',
      'Because there are 13 presidents',
      'Because there are 13 amendments',
    ],
  ),
  const Question(
    number: 120,
    category: 'Symbols',
    question: 'Why does the flag have 50 stars?',
    answer: 'Because there are 50 states',
    options: [
      'Because there are 50 states',
      'Because there are 50 colonies',
      'Because there are 50 presidents',
      'Because there are 50 amendments',
    ],
  ),
  const Question(
    number: 121,
    category: 'Holidays',
    question: 'What is the name of the national anthem?',
    answer: 'The Star-Spangled Banner',
    options: [
      'The Star-Spangled Banner',
      'America the Beautiful',
      'God Bless America',
      'My Country, Tis of Thee',
    ],
  ),
  const Question(
    number: 122,
    category: 'Holidays',
    question: 'When do we celebrate Independence Day?',
    answer: 'July 4',
    options: ['July 4', 'January 1', 'December 25', 'November 11'],
  ),
  const Question(
    number: 123,
    category: 'American Government',
    question: 'What is the form of government of the United States?',
    answer: 'Republic',
    options: ['Republic', 'Monarchy', 'Dictatorship', 'Oligarchy'],
  ),
  const Question(
    number: 124,
    category: 'Rights and Responsibilities',
    question: 'What is one right only for citizens?',
    answer: 'Vote in a federal election',
    options: [
      'Vote in a federal election',
      'Freedom of speech',
      'Freedom of religion',
      'Right to fair trial',
    ],
  ),
  const Question(
    number: 125,
    category: 'Rights and Responsibilities',
    question: 'What is one responsibility only for citizens?',
    answer: 'Serve on a jury',
    options: ['Serve on a jury', 'Pay rent', 'Drive a car', 'Go to school'],
  ),
  const Question(
    number: 126,
    category: 'American History',
    question: 'Who lived in America before the Europeans arrived?',
    answer: 'American Indians',
    options: ['American Indians', 'Europeans', 'Africans', 'Asians'],
  ),
  const Question(
    number: 127,
    category: 'American History',
    question: 'What movement tried to end racial discrimination?',
    answer: 'Civil rights movement',
    options: [
      'Civil rights movement',
      'Tea Party movement',
      'Space movement',
      'Labor movement',
    ],
  ),
  const Question(
    number: 128,
    category: 'American History',
    question: 'Name one American Indian tribe in the United States.',
    answer: 'Cherokee',
    options: ['Cherokee', 'Zulu', 'Maori', 'Viking'],
  ),
];

// ============ THEME PROVIDER ============
class ThemeProvider extends ChangeNotifier {
  bool isDark = false;
  ThemeProvider() {
    _load();
  }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    isDark = p.getBool('isDark') ?? false;
    notifyListeners();
  }

  Future<void> toggle() async {
    isDark = !isDark;
    final p = await SharedPreferences.getInstance();
    await p.setBool('isDark', isDark);
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8F9FF),
    colorScheme: ColorScheme.fromSeed(
      seedColor: accentBlue,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0A0F1E),
    colorScheme: ColorScheme.fromSeed(
      seedColor: accentBlue,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A1931),
      foregroundColor: Colors.white,
    ),
  );
}

// ============ APP ============
class CitizenshipApp extends StatefulWidget {
  const CitizenshipApp({super.key});
  @override
  State<CitizenshipApp> createState() => _CitizenshipAppState();
}

class _CitizenshipAppState extends State<CitizenshipApp> {
  final themeProvider = ThemeProvider();
  @override
  void initState() {
    super.initState();
    themeProvider.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'US Citizenship 2027',
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      home: SplashPage(themeProvider: themeProvider),
    );
  }
}

// ============ PREMIUM SPLASH SCREEN ============
class SplashPage extends StatefulWidget {
  final ThemeProvider themeProvider;
  const SplashPage({super.key, required this.themeProvider});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade, _scale;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.7, curve: Curves.easeOut),
      ),
    );
    _scale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.8, curve: Curves.elasticOut),
      ),
    );
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      final prefs = await SharedPreferences.getInstance();
      final started = prefs.getBool('started') ?? false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => started
              ? HomePage(themeProvider: widget.themeProvider)
              : GetStartedPage(themeProvider: widget.themeProvider),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A1931), Color(0xFF185ADB), Color(0xFF0A1931)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.account_balance,
                      color: Colors.white,
                      size: 72,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'US CITIZENSHIP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const Text(
                    '2027',
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'OFFICIAL • 128 QUESTIONS • PREMIUM',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============ PREMIUM GET STARTED ============
class GetStartedPage extends StatelessWidget {
  final ThemeProvider themeProvider;
  const GetStartedPage({super.key, required this.themeProvider});
  Future<void> start(BuildContext c) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('started', true);
    if (!c.mounted) return;
    Navigator.pushReplacement(
      c,
      MaterialPageRoute(builder: (_) => HomePage(themeProvider: themeProvider)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, const Color(0xFFF0F4FF)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [primaryBlue, accentBlue],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accentBlue.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.flag, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 28),
                const Text(
                  'US Citizenship\nTest 2027',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: primaryBlue,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Master all 128 official USCIS civics questions with premium preparation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    _feature(
                      Icons.category_rounded,
                      'Category Wise',
                      '5 Categories',
                    ),
                    const SizedBox(width: 12),
                    _feature(Icons.quiz_rounded, '20 Mock Tests', '10 Q Each'),
                    const SizedBox(width: 12),
                    _feature(
                      Icons.verified_rounded,
                      'Premium',
                      'Detailed Answers',
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.shield_rounded, color: Colors.green),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '100% Offline • No Ads • Official Content',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                    ),
                    onPressed: () => start(context),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Trusted by 50,000+ future citizens',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _feature(IconData icon, String title, String sub) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withOpacity(0.06)),
        ),
        child: Column(
          children: [
            Icon(icon, color: accentBlue, size: 26),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              sub,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ HOME ============
class HomePage extends StatefulWidget {
  final ThemeProvider themeProvider;
  const HomePage({super.key, required this.themeProvider});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeContent(themeProvider: widget.themeProvider),
      MockTestHomePage(themeProvider: widget.themeProvider),
      SettingsPage(themeProvider: widget.themeProvider),
    ];
    return Scaffold(
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz_rounded),
            label: 'Mock Tests',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final ThemeProvider themeProvider;
  const HomeContent({super.key, required this.themeProvider});
  @override
  Widget build(BuildContext context) {
    final categories = questions.map((e) => e.category).toSet().toList();
    final totalByCat = {
      for (var c in categories)
        c: questions.where((q) => q.category == c).length,
    };
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150,
            backgroundColor: primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [primaryBlue, accentBlue]),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'US Citizenship 2027',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: goldColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '128 QUESTIONS',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: primaryBlue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'ENGLISH ONLY • OFFICIAL',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: themeProvider.isDark
                                ? Colors.white.withOpacity(0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '128',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: accentBlue,
                                ),
                              ),
                              Text(
                                'Total Questions',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: themeProvider.isDark
                                ? Colors.white.withOpacity(0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '5',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: themeProvider.isDark
                                ? Colors.white.withOpacity(0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '20',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Mock Tests',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'All questions organized by official USCIS categories',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((c, i) {
              final cat = categories[i];
              final count = totalByCat[cat]!;
              IconData icon;
              Color color;
              switch (cat) {
                case 'American Government':
                  icon = Icons.account_balance_rounded;
                  color = accentBlue;
                  break;
                case 'Rights and Responsibilities':
                  icon = Icons.gavel_rounded;
                  color = Colors.purple;
                  break;
                case 'American History':
                  icon = Icons.history_edu_rounded;
                  color = Colors.orange;
                  break;
                case 'Geography':
                  icon = Icons.public_rounded;
                  color = Colors.green;
                  break;
                default:
                  icon = Icons.celebration_rounded;
                  color = Colors.red;
              }
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: themeProvider.isDark
                      ? Colors.white.withOpacity(0.06)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color),
                  ),
                  title: Text(
                    cat,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    '$count questions • English only',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuestionListPage(
                          title: cat,
                          questions: questions
                              .where((q) => q.category == cat)
                              .toList(),
                          themeProvider: themeProvider,
                        ),
                      ),
                    );
                  },
                ),
              );
            }, childCount: categories.length),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class QuestionListPage extends StatelessWidget {
  final String title;
  final List<Question> questions;
  final ThemeProvider themeProvider;
  const QuestionListPage({
    super.key,
    required this.title,
    required this.questions,
    required this.themeProvider,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: questions.length,
        itemBuilder: (c, i) {
          final q = questions[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: themeProvider.isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
              ],
            ),
            child: ExpansionTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${q.number}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentBlue,
                    fontSize: 12,
                  ),
                ),
              ),
              title: Text(
                q.question,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                q.answer,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Options:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...q.options.map(
                        (o) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Icon(
                                o == q.answer
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                size: 16,
                                color: o == q.answer
                                    ? Colors.green
                                    : Colors.black26,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  o,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: o == q.answer ? Colors.green : null,
                                    fontWeight: o == q.answer
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MockTestHomePage extends StatefulWidget {
  final ThemeProvider themeProvider;
  const MockTestHomePage({super.key, required this.themeProvider});
  @override
  State<MockTestHomePage> createState() => _MockTestHomePageState();
}

class _MockTestHomePageState extends State<MockTestHomePage> {
  int completed = 0;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => completed = p.getInt('completed_tests') ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final unlocked = min(20, 10 + (completed ~/ 1 >= 10 ? 10 : 0));
    final actualUnlocked = completed >= 10 ? 20 : 10;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [primaryBlue, accentBlue]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mock Tests',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$completed/20 Completed • $actualUnlocked Unlocked',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: completed / 20,
                        backgroundColor: Colors.white24,
                        color: goldColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    color: goldColor,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Complete 10 tests to unlock next 10',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(20, (i) {
            final n = i + 1;
            final isUnlocked = n <= actualUnlocked;
            final isCompleted = n <= completed;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: widget.themeProvider.isDark
                    ? Colors.white.withOpacity(0.06)
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isCompleted
                      ? Colors.green.withOpacity(0.3)
                      : Colors.transparent,
                ),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green.withOpacity(0.12)
                        : isUnlocked
                        ? accentBlue.withOpacity(0.12)
                        : Colors.black12,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check_rounded
                        : isUnlocked
                        ? Icons.play_arrow_rounded
                        : Icons.lock_rounded,
                    color: isCompleted
                        ? Colors.green
                        : isUnlocked
                        ? accentBlue
                        : Colors.black38,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Mock Test $n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? null : Colors.black38,
                  ),
                ),
                subtitle: Text(
                  isCompleted
                      ? 'Completed • 10 Questions'
                      : isUnlocked
                      ? '10 Questions • English Only'
                      : 'Complete 10 tests to unlock',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: isUnlocked
                    ? const Icon(Icons.chevron_right_rounded)
                    : null,
                onTap: isUnlocked
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MockTestPage(
                              testNumber: n,
                              themeProvider: widget.themeProvider,
                            ),
                          ),
                        ).then((_) => _load());
                      }
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class MockTestPage extends StatefulWidget {
  final int testNumber;
  final ThemeProvider themeProvider;
  const MockTestPage({
    super.key,
    required this.testNumber,
    required this.themeProvider,
  });
  @override
  State<MockTestPage> createState() => _MockTestPageState();
}

class _MockTestPageState extends State<MockTestPage> {
  late List<Question> tqs;
  int cur = 0;
  int score = 0;
  String? sel;
  @override
  void initState() {
    super.initState();
    final s = List<Question>.from(questions)
      ..shuffle(Random(widget.testNumber * 99));
    tqs = s.take(10).toList();
  }

  void choose(String o) => setState(() => sel = o);
  Future<void> next() async {
    if (sel == null) return;
    if (sel == tqs[cur].answer) score++;
    if (cur == 9) {
      final p = await SharedPreferences.getInstance();
      final prev = p.getInt('completed_tests') ?? 0;
      if (widget.testNumber > prev)
        await p.setInt('completed_tests', widget.testNumber);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(
            score: score,
            passed: score >= 6,
            themeProvider: widget.themeProvider,
          ),
        ),
      );
      return;
    }
    setState(() => cur++);
    sel = null;
  }

  @override
  Widget build(BuildContext context) {
    final q = tqs[cur];
    return Scaffold(
      appBar: AppBar(
        title: Text('Test ${widget.testNumber} • Q${cur + 1}/10'),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (cur + 1) / 10,
            backgroundColor: Colors.black12,
            color: accentBlue,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: accentBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      q.category,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: accentBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    q.question,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView(
                      children: q.options.map((o) {
                        final isSel = sel == o;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: isSel
                                ? accentBlue.withOpacity(0.08)
                                : widget.themeProvider.isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSel ? accentBlue : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: RadioListTile(
                            value: o,
                            groupValue: sel,
                            title: Text(
                              o,
                              style: TextStyle(
                                fontWeight: isSel
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                            onChanged: (v) {
                              if (v != null) choose(v);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: sel == null ? null : next,
                      child: Text(
                        cur == 9 ? 'Finish Test' : 'Next Question',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final bool passed;
  final ThemeProvider themeProvider;
  const ResultPage({
    super.key,
    required this.score,
    required this.passed,
    required this.themeProvider,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: passed
                ? [Colors.green.shade700, Colors.green.shade400]
                : [Colors.red.shade700, Colors.orange.shade400],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 20),
                      ],
                    ),
                    child: Icon(
                      passed
                          ? Icons.emoji_events_rounded
                          : Icons.refresh_rounded,
                      size: 64,
                      color: passed ? Colors.green : Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    passed ? 'Congratulations!' : 'Keep Practicing!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$score / 10 Correct',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    passed
                        ? 'You passed this mock test! (6+ to pass)'
                        : 'You need 6 correct to pass. Try again!',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Score'),
                            Text(
                              '$score/10',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: score / 10,
                          backgroundColor: Colors.black12,
                          color: passed ? Colors.green : Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: passed ? Colors.green : Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back to Tests',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final ThemeProvider themeProvider;
  const SettingsPage({super.key, required this.themeProvider});
  Future<void> openPrivacy(BuildContext c) async {
    final uri = Uri.parse(privacyUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          const Text(
            'Settings',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: themeProvider.isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.dark_mode_rounded,
                      color: Colors.orange,
                    ),
                  ),
                  title: const Text(
                    'Dark Mode',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    themeProvider.isDark
                        ? 'Black theme enabled'
                        : 'White theme enabled',
                  ),
                  trailing: Switch(
                    value: themeProvider.isDark,
                    onChanged: (_) => themeProvider.toggle(),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accentBlue.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.privacy_tip_rounded,
                      color: accentBlue,
                    ),
                  ),
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('View privacy policy'),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                  onTap: () => openPrivacy(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.info_rounded, color: Colors.green),
                  ),
                  title: const Text(
                    'About App',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    '128 Questions • 5 Categories • 20 Mock Tests\nVersion 1.0.0 • English Only • Official',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: themeProvider.isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.logout_rounded, color: Colors.red),
                  ),
                  title: const Text(
                    'Reset Progress',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Clear all mock test progress'),
                  onTap: () async {
                    final p = await SharedPreferences.getInstance();
                    await p.setInt('completed_tests', 0);
                    if (context.mounted)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Progress reset!')),
                      );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.red,
                    ),
                  ),
                  title: const Text(
                    'Exit App',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: const Text('Close the application'),
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'US Citizenship 2027',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Made for future Americans 🇺🇸',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
