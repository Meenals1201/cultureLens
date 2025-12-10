-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2025 at 11:51 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `culturelens`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name`) VALUES
(1, 'Teamwork & Collaboration'),
(2, 'Innovation & Learning'),
(3, 'Ethics & Transparency'),
(4, 'Work-Life Balance & Purpose'),
(5, 'Career Growth & Recognition');

-- --------------------------------------------------------

--
-- Table structure for table `organisations`
--

CREATE TABLE `organisations` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `about` text NOT NULL,
  `application_link` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organisations`
--

INSERT INTO `organisations` (`id`, `category_id`, `name`, `about`, `application_link`) VALUES
(1, 1, 'SickKids', 'At SickKids, Canada\'s most research-intensive children\'s hospital, our mission to advance child health is a collective effort. We bring together world-leading clinicians, dedicated nurses, pioneering researchers, and passionate support staff in deeply integrated teams. Every breakthrough in care and discovery is made possible through a culture of unwavering collaboration, where diverse expertise converges to solve complex challenges. Here, you\'ll join a team where your role is interconnected, valued, and vital to our shared purpose.\r\n', 'https://www.sickkids.ca/en/careers/'),
(2, 1, 'Canada Goose', 'At Canada Goose, crafting the world’s finest performance luxury apparel is a collective endeavor that unites designers, craftspeople, planners, and logistics experts. Every parka embodies seamless collaboration across departments—from concept and materials sourcing through meticulous manufacturing to global distribution. We operate with a shared commitment to quality, innovation, and heritage, knowing that our success depends on every team member’s contribution. Here, you’ll join a tightly knit community where cross-functional partnership is essential to delivering iconic products trusted by people around the world.', 'https://www.canadagoose.com/en/careers.html'),
(3, 2, 'Shopify', 'Shopify is the leading global commerce company, providing the tools and platform for entrepreneurs to start, grow, and scale their businesses. We operate on the belief that the best solutions aren\'t yet known, fostering a culture of constant experimentation, rapid iteration, and hands-on learning. Every team member is empowered to challenge the status quo, solve novel problems, and grow their skills in real-time. If you\'re driven by curiosity and thrive in a dynamic environment of perpetual innovation, you belong here.', 'https://www.shopify.com/careers'),
(4, 2, 'University of Toronto', 'As one of the world\'s top research universities, the University of Toronto is a powerhouse of discovery, creativity, and knowledge generation. Our vibrant academic community is dedicated to pushing the boundaries of what is known and educating the next generation of leaders. Here, innovation happens at the intersection of disciplines, fueled by a relentless commitment to learning—for our students, faculty, and staff. Working at U of T means contributing to an environment where intellectual growth and groundbreaking ideas are a daily pursuit.', 'https://hrandequity.utoronto.ca/careers/'),
(5, 3, 'Hydro One', 'Hydro One is Ontario\'s largest electricity transmission and distribution provider, delivering safe and reliable power to millions of homes and businesses. As a critical public trust, we operate with the highest ethical standards, absolute integrity, and a deep commitment to transparency with our customers, communities, and regulators. Our culture is built on accountability, safety, and doing the right thing—always. Join us to power Ontario\'s future in a role where principled conduct is the foundation of everything we do.', 'https://www.hydroone.com/careers'),
(6, 3, 'Sun Life Financial\r\n', 'Sun Life is a leading international financial services organization, helping clients achieve lifetime financial security and live healthier lives. In a business built on trust, we are committed to unwavering ethical conduct, clarity in our communications, and transparency in our dealings with clients and partners. Our strong governance and client-first philosophy ensure that integrity is not just a policy but a core practice. Build a meaningful career with us, where your work strengthens the trust placed in us every day.', 'https://www.sunlife.ca/en/careers/'),
(7, 4, 'Ontario Public Service (OPS)', 'The Ontario Public Service is dedicated to serving the people of Ontario by developing and delivering vital programs and services that shape our province. We offer a mission-driven career with a profound sense of purpose, balanced by a commitment to employee well-being through flexible work arrangements, comprehensive benefits, and a supportive culture. Your work here directly contributes to the public good, allowing you to build a rewarding career that also respects your life outside of it.', 'https://www.gojobs.gov.on.ca/'),
(8, 4, 'Ceridian', 'Ceridian is a global human capital management technology company, and our purpose is to make work life better. Through our flagship platform, Dayforce, we help organizations empower their people. We live this purpose internally by championing flexibility, fostering inclusion, and providing tools that help our own people thrive both professionally and personally. At Ceridian, you\'ll join a team dedicated to transforming the world of work, starting with our own.', 'https://www.dayforce.com/who-we-are/careers'),
(9, 5, 'IBM Canada', 'IBM is a leading hybrid cloud and AI solutions provider, with a century-long legacy of reinvention. In Canada, we invest heavily in our people through structured learning paths, clear career frameworks, and opportunities to work on transformative global projects. Your growth is fueled by access to cutting-edge technology, mentorship programs, and a culture that recognizes achievement and expertise. Build a lasting career with us, where your development is a priority and your contributions are valued.', 'https://www.ibm.com/ca-en/careers'),
(10, 5, 'TD Bank Group', 'The TD Bank Group is a leading North American financial institution, driven by a commitment to enriching the lives of our customers, communities, and colleagues. We foster an environment of internal mobility and invest in your growth through comprehensive training, leadership development programs, and clear paths for advancement. TD is a place where your ambitions are supported, your performance is recognized, and you can build a long-term, progressive career while making a meaningful impact.', 'https://jobs.td.com/');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `question_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `category_id`, `question_text`) VALUES
(2, 1, 'I feel comfortable voicing my opinions in a team.'),
(3, 1, 'I enjoy mentoring or helping others grow.'),
(4, 2, 'I enjoy experimenting with new ideas and technologies.'),
(5, 2, 'I value workplaces that encourage continuous learning.'),
(6, 2, 'I enjoy learning from failure and taking calculated risks.'),
(7, 3, 'I value transparency and honesty from leadership.'),
(8, 3, 'Diversity and inclusivity in the workplace are important to me.'),
(9, 3, 'Recognition and appreciation for my work are important to me.'),
(10, 4, 'I prefer a flexible work schedule over a strict 9-5.'),
(11, 4, 'I feel motivated when my work has a positive impact on society.'),
(12, 4, 'I thrive in high-pressure, fast-paced work environments.'),
(13, 5, 'I like having clear instructions and guidelines before starting a task.'),
(14, 5, 'I prefer clear goals and measurable success metrics.'),
(15, 5, 'I like having opportunities to mentor or help others grow.'),
(16, 1, 'I prefer working in collaborative teams over working alone.');

-- --------------------------------------------------------

--
-- Table structure for table `responses`
--

CREATE TABLE `responses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `score` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `responses`
--

INSERT INTO `responses` (`id`, `user_id`, `question_id`, `score`) VALUES
(0, 4, 1, 0),
(0, 4, 2, 0),
(0, 4, 3, 0),
(0, 4, 4, 2),
(0, 4, 5, 2),
(0, 4, 6, 3),
(0, 4, 7, 3),
(0, 4, 8, 4),
(0, 4, 9, 4),
(0, 4, 10, 3),
(0, 4, 11, 3),
(0, 4, 12, 3),
(0, 4, 13, 3),
(0, 4, 14, 3),
(0, 4, 15, 3),
(0, 4, 1, 0),
(0, 4, 2, 4),
(0, 4, 3, 2),
(0, 4, 4, 1),
(0, 4, 5, 3),
(0, 4, 6, 2),
(0, 4, 7, 3),
(0, 4, 8, 2),
(0, 4, 9, 2),
(0, 4, 10, 4),
(0, 4, 11, 1),
(0, 4, 12, 2),
(0, 4, 13, 1),
(0, 4, 14, 3),
(0, 4, 15, 1),
(0, 3, 1, 0),
(0, 3, 2, 0),
(0, 3, 3, 0),
(0, 3, 4, 1),
(0, 3, 5, 1),
(0, 3, 6, 1),
(0, 3, 7, 2),
(0, 3, 8, 2),
(0, 3, 9, 2),
(0, 3, 10, 1),
(0, 3, 11, 1),
(0, 3, 12, 3),
(0, 3, 13, 4),
(0, 3, 14, 4),
(0, 3, 15, 4),
(0, 3, 1, 2),
(0, 3, 2, 2),
(0, 3, 3, 2),
(0, 3, 4, 2),
(0, 3, 5, 2),
(0, 3, 6, 2),
(0, 3, 7, 2),
(0, 3, 8, 2),
(0, 3, 9, 2),
(0, 3, 10, 2),
(0, 3, 11, 2),
(0, 3, 12, 2),
(0, 3, 13, 2),
(0, 3, 14, 2),
(0, 3, 15, 2),
(0, 3, 1, 4),
(0, 3, 2, 4),
(0, 3, 3, 4),
(0, 3, 4, 2),
(0, 3, 5, 4),
(0, 3, 6, 1),
(0, 3, 7, 4),
(0, 3, 8, 1),
(0, 3, 9, 3),
(0, 3, 10, 1),
(0, 3, 11, 3),
(0, 3, 12, 1),
(0, 3, 13, 1),
(0, 3, 14, 0),
(0, 3, 15, 0),
(0, 8, 2, 0),
(0, 8, 3, 0),
(0, 8, 4, 0),
(0, 8, 5, 3),
(0, 8, 6, 4),
(0, 8, 7, 4),
(0, 8, 8, 4),
(0, 8, 9, 4),
(0, 8, 10, 2),
(0, 8, 11, 1),
(0, 8, 12, 3),
(0, 8, 13, 2),
(0, 8, 14, 3),
(0, 8, 15, 2),
(0, 8, 16, 2),
(0, 3, 2, 0),
(0, 3, 3, 0),
(0, 3, 4, 2),
(0, 3, 5, 2),
(0, 3, 6, 2),
(0, 3, 7, 4),
(0, 3, 8, 4),
(0, 3, 9, 4),
(0, 3, 10, 4),
(0, 3, 11, 4),
(0, 3, 12, 4),
(0, 3, 13, 4),
(0, 3, 14, 4),
(0, 3, 15, 4),
(0, 3, 16, 1),
(0, 3, 2, 0),
(0, 3, 3, 0),
(0, 3, 4, 2),
(0, 3, 5, 2),
(0, 3, 6, 2),
(0, 3, 7, 4),
(0, 3, 8, 4),
(0, 3, 9, 4),
(0, 3, 10, 4),
(0, 3, 11, 4),
(0, 3, 12, 4),
(0, 3, 13, 4),
(0, 3, 14, 4),
(0, 3, 15, 4),
(0, 3, 16, 1),
(0, 3, 2, 2),
(0, 3, 3, 2),
(0, 3, 4, 3),
(0, 3, 5, 1),
(0, 3, 6, 4),
(0, 3, 7, 3),
(0, 3, 8, 3),
(0, 3, 9, 3),
(0, 3, 10, 2),
(0, 3, 11, 0),
(0, 3, 12, 4),
(0, 3, 13, 2),
(0, 3, 14, 0),
(0, 3, 15, 2),
(0, 3, 16, 3),
(0, 3, 2, 0),
(0, 3, 3, 0),
(0, 3, 4, 2),
(0, 3, 5, 3),
(0, 3, 6, 1),
(0, 3, 7, 4),
(0, 3, 8, 2),
(0, 3, 9, 4),
(0, 3, 10, 1),
(0, 3, 11, 3),
(0, 3, 12, 2),
(0, 3, 13, 3),
(0, 3, 14, 4),
(0, 3, 15, 2),
(0, 3, 16, 4),
(0, 4, 2, 3),
(0, 4, 3, 2),
(0, 4, 4, 1),
(0, 4, 5, 2),
(0, 4, 6, 3),
(0, 4, 7, 2),
(0, 4, 8, 3),
(0, 4, 9, 1),
(0, 4, 10, 4),
(0, 4, 11, 2),
(0, 4, 12, 2),
(0, 4, 13, 2),
(0, 4, 14, 3),
(0, 4, 15, 2),
(0, 4, 16, 2),
(0, 4, 2, 3),
(0, 4, 3, 2),
(0, 4, 4, 1),
(0, 4, 5, 2),
(0, 4, 6, 3),
(0, 4, 7, 2),
(0, 4, 8, 3),
(0, 4, 9, 1),
(0, 4, 10, 4),
(0, 4, 11, 2),
(0, 4, 12, 2),
(0, 4, 13, 2),
(0, 4, 14, 3),
(0, 4, 15, 2),
(0, 4, 16, 2),
(0, 4, 2, 3),
(0, 4, 3, 2),
(0, 4, 4, 1),
(0, 4, 5, 2),
(0, 4, 6, 3),
(0, 4, 7, 2),
(0, 4, 8, 3),
(0, 4, 9, 1),
(0, 4, 10, 4),
(0, 4, 11, 2),
(0, 4, 12, 2),
(0, 4, 13, 2),
(0, 4, 14, 3),
(0, 4, 15, 2),
(0, 4, 16, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`) VALUES
(1, 'Meenal', 'meenal@gmail.com', 'admin', 'admin'),
(2, 'Sabah', 'maggie@gmail.com', 'maggie123', 'member'),
(3, 'Uttam', 'ugs@gmail.com', '1234', 'member'),
(4, 'Samia', 's@gmail.com', 's123', 'member'),
(5, 'simmi', 'sim@gmail.com', 'simmi', 'member'),
(6, 'Simran', 'simm@gamil.com', 'test', 'member'),
(7, 'testme', 't@gmail.com', 'test', 'member'),
(8, 'Mannat', 'm@gmail.com', 'monney', 'member');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organisations`
--
ALTER TABLE `organisations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `organisations`
--
ALTER TABLE `organisations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
