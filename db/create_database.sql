-- phpMyAdmin SQL Dump
-- version 4.6.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 26-Set-2016 às 17:00
-- Versão do servidor: 5.7.13-0ubuntu0.16.04.2
-- PHP Version: 5.6.25-2+deb.sury.org~xenial+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amigochef`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `slug` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `slug`) VALUES
(1, 'Japonês', 'japones'),
(2, 'Árabe', 'arabe');

-- --------------------------------------------------------

--
-- Estrutura da tabela `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `event_type_id` int(11) NOT NULL,
  `num_users` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `status` enum('enable','disable') DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `neighborhood` varchar(100) DEFAULT NULL,
  `latitude` mediumtext,
  `longitude` mediumtext,
  `description` text,
  `picture` varchar(255) NOT NULL DEFAULT 'default.jpg',
  `end_subscription` datetime DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `invite_limit` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `events`
--

INSERT INTO `events` (`event_id`, `user_id`, `start`, `end`, `name`, `event_type_id`, `num_users`, `price`, `status`, `street`, `state`, `city`, `neighborhood`, `latitude`, `longitude`, `description`, `picture`, `end_subscription`, `create_time`, `invite_limit`) VALUES
(3, 2, '2016-09-08 00:00:00', '2016-09-23 00:00:00', 'Churras', 1, NULL, NULL, 'enable', NULL, NULL, NULL, NULL, NULL, NULL, 'Esse churrasco vai ser bem legal', 'default.jpg', NULL, NULL, NULL),
(4, 2, '2016-09-08 00:00:00', '2016-09-23 00:00:00', 'Churras 2', 1, NULL, NULL, 'enable', NULL, NULL, NULL, NULL, NULL, NULL, 'Esse churrasco vai ser bem legal', 'default.jpg', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `event_comments`
--

CREATE TABLE `event_comments` (
  `event_comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `datetime` timestamp NULL DEFAULT NULL,
  `comment` text,
  `status` enum('enable','disable') DEFAULT 'enable'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `event_gallery`
--

CREATE TABLE `event_gallery` (
  `event_gallery_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `event_guests`
--

CREATE TABLE `event_guests` (
  `event_guest_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` enum('invited','confirmed') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `event_guests`
--

INSERT INTO `event_guests` (`event_guest_id`, `event_id`, `user_id`, `updated_at`, `status`) VALUES
(1, 3, 8, NULL, 'invited'),
(2, 4, 8, NULL, 'invited');

-- --------------------------------------------------------

--
-- Estrutura da tabela `event_infos`
--

CREATE TABLE `event_infos` (
  `event_info_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `event_info_type_id` int(11) DEFAULT NULL,
  `info_value` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `event_info_types`
--

CREATE TABLE `event_info_types` (
  `event_info_type_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `field_type` enum('text','textarea','radio','select','checkbox') NOT NULL DEFAULT 'text',
  `field_values` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `event_types`
--

CREATE TABLE `event_types` (
  `event_type_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `event_types`
--

INSERT INTO `event_types` (`event_type_id`, `name`) VALUES
(1, 'Jantar');

-- --------------------------------------------------------

--
-- Estrutura da tabela `friends`
--

CREATE TABLE `friends` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `friends`
--

INSERT INTO `friends` (`id`, `user_id`, `friend_id`) VALUES
(9, 8, 2),
(10, 2, 8);

-- --------------------------------------------------------

--
-- Estrutura da tabela `invite_codes`
--

CREATE TABLE `invite_codes` (
  `invite_id` int(11) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `event_id` int(11) NOT NULL,
  `status` enum('pending','registered') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `invite_codes`
--

INSERT INTO `invite_codes` (`invite_id`, `code`, `email`, `event_id`, `status`) VALUES
(5, '123', 'de.akao@gmail.com', 3, 'registered');

-- --------------------------------------------------------

--
-- Estrutura da tabela `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `timestamp` int(10) UNSIGNED ZEROFILL NOT NULL,
  `data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `sessions`
--

INSERT INTO `sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('000c31bf89a9d02e59e4a84014d32dc9c30f0a51', '127.0.0.1', 1474550053, '__ci_last_regenerate|i:1474550053;'),
('001ad443f3a69c9d06f8177cf879208c91256cc5', '127.0.0.1', 1473853940, '__ci_last_regenerate|i:1473853940;'),
('005b5bcc0dd8c768726c1d18251f223eb5dad866', '127.0.0.1', 1473880232, '__ci_last_regenerate|i:1473880232;'),
('0090160d12a1c33c605ba255e89a93e6bc061e8b', '127.0.0.1', 1473880276, '__ci_last_regenerate|i:1473880276;'),
('0090d98ec002ae874b20a33ea250255434b2dff4', '127.0.0.1', 1473886846, '__ci_last_regenerate|i:1473886846;'),
('00ac3784f3f63240d0ce30e625ffb18436d384cf', '127.0.0.1', 1474550174, '__ci_last_regenerate|i:1474550174;'),
('01ae98c230cd7787f6ad61bcfc23890ebc2ec57d', '127.0.0.1', 1474545136, '__ci_last_regenerate|i:1474545136;'),
('01fb4bdda4deec75a7cc325e95cdb9d858b25779', '127.0.0.1', 1474483974, '__ci_last_regenerate|i:1474483974;'),
('023191dfaf3f0bc264de14e068426fbc7aa54caa', '127.0.0.1', 1473883315, '__ci_last_regenerate|i:1473883315;'),
('0267f8ca4113d7e9577c19b0410661c93a267dc8', '127.0.0.1', 1473854559, '__ci_last_regenerate|i:1473854559;'),
('029bc3cd82abec105370660b1343d7e3d72b1a54', '192.168.1.172', 1473459456, '__ci_last_regenerate|i:1473459456;'),
('02de69d51b7b18a5fe44f73b2ac268137aaf9d14', '127.0.0.1', 1473381826, '__ci_last_regenerate|i:1473381826;'),
('0345c629dd17fe2c7a2005f5796661687873e40a', '192.168.1.172', 1473459333, '__ci_last_regenerate|i:1473459333;'),
('03a09b8921278ba7529527a9e5823a66c91d6c5a', '127.0.0.1', 1473879800, '__ci_last_regenerate|i:1473879800;'),
('03da9ea9da789714496f476fead168b4c1ddd6ca', '127.0.0.1', 1473381234, '__ci_last_regenerate|i:1473381234;'),
('040966ffd2ee488ae21424ca4a0f92083d1527d6', '127.0.0.1', 1473802242, '__ci_last_regenerate|i:1473802242;'),
('04464461cdf24e87a87b010d14992dd66b284847', '127.0.0.1', 1472592861, '__ci_last_regenerate|i:1472592788;'),
('0449db99e3da4e877bc05c2a965ce649a4526618', '127.0.0.1', 1473886443, '__ci_last_regenerate|i:1473886443;'),
('04505e78d97553ebc0f623e909effe4ad6958b9e', '127.0.0.1', 1473787153, '__ci_last_regenerate|i:1473787153;'),
('04c9033ae39075f90b6965031fba2a98bd4411a4', '127.0.0.1', 1473880263, '__ci_last_regenerate|i:1473880263;'),
('0510618db8f3bcf060bd8232c8ddda67efc028a0', '127.0.0.1', 1473880256, '__ci_last_regenerate|i:1473880256;'),
('05383340d0cdb5bf72e54a81614445b47dd96f6c', '127.0.0.1', 1474493064, '__ci_last_regenerate|i:1474493064;'),
('05a970602754693d28fa45394b8f62d2896146e7', '127.0.0.1', 1473772363, '__ci_last_regenerate|i:1473772363;'),
('062409e4363c85bbd22aa397e62b78da5417286f', '127.0.0.1', 1473885913, '__ci_last_regenerate|i:1473885913;'),
('0639ea60160e7358508f24fad785f8989d24b20d', '127.0.0.1', 1473879800, '__ci_last_regenerate|i:1473879800;'),
('06527384e33d1b5e5137e2219f81bb0a521c78bb', '127.0.0.1', 1474549263, '__ci_last_regenerate|i:1474549263;'),
('06c099ee3c72a1617e9da80b499f5374582dda16', '127.0.0.1', 1473802102, '__ci_last_regenerate|i:1473802102;'),
('071ce76e3f39ceba52a43b94b6e1f028c884465d', '127.0.0.1', 1473947732, '__ci_last_regenerate|i:1473947732;'),
('0752694f7e3ec821274e1bbc0bff7d18ae00282e', '192.168.1.164', 1473429692, '__ci_last_regenerate|i:1473429692;'),
('07949f16480c2a23e97cf2ef996e332e066790c3', '192.168.1.164', 1473426869, '__ci_last_regenerate|i:1473426869;'),
('080906151824474ef2f9ec7043ba9db3221f9b3a', '127.0.0.1', 1473775022, '__ci_last_regenerate|i:1473775022;'),
('0811aa69d541e52541f6ce7c0c686b9d8b8e28ee', '127.0.0.1', 1473888122, '__ci_last_regenerate|i:1473888122;'),
('08549569c746387d16083299e72c919984554a7d', '127.0.0.1', 1473883932, '__ci_last_regenerate|i:1473883932;'),
('087c851b1f892a9d59a99689a0f5e2d53191f850', '127.0.0.1', 1474491703, '__ci_last_regenerate|i:1474491703;'),
('08a3b0007ab96c8010ddeb908a8d90b258ba1832', '127.0.0.1', 1473886859, '__ci_last_regenerate|i:1473886859;'),
('08d484f5d9a444f7e0680ceddfe0a6f728668858', '127.0.0.1', 1473886507, '__ci_last_regenerate|i:1473886507;'),
('09c8f13c44dcacc7c1b1f21177e8ac8c1c0251f8', '127.0.0.1', 1474486322, '__ci_last_regenerate|i:1474486322;'),
('09d9f3272a34a59ffadf03c28b2c8a8982410871', '127.0.0.1', 1473948094, '__ci_last_regenerate|i:1473948094;'),
('0aa7e6dbeb597fd31601f4d1ab0ca2af440f4bef', '127.0.0.1', 1473802642, '__ci_last_regenerate|i:1473802642;'),
('0ae5a54fe5944251559089956ae6b69ab0ecb044', '127.0.0.1', 1473774456, '__ci_last_regenerate|i:1473774456;'),
('0bfda1e771a4a784b9d22332afa2bf0cd61590d1', '127.0.0.1', 1473886859, '__ci_last_regenerate|i:1473886859;'),
('0c062dedd57b424d43cfa2571b4d77533ba2130f', '127.0.0.1', 1473947955, '__ci_last_regenerate|i:1473947955;'),
('0c19d301d95d8f4dcc267c7d9a5349799f7c8995', '127.0.0.1', 1472571327, '__ci_last_regenerate|i:1472571028;'),
('0c4fc4c6236b0e43922c09b0d13ca0a204f77aac', '127.0.0.1', 1474549299, '__ci_last_regenerate|i:1474549299;'),
('0c9d30a06292934d7902a911dbddd08b1a69ab9d', '192.168.1.133', 1473949309, '__ci_last_regenerate|i:1473949309;'),
('0cbae085d1684904b1568bf165db02a2ebf955bc', '127.0.0.1', 1474545118, '__ci_last_regenerate|i:1474545118;'),
('0cf3a70e7542421e27184b78be8b35c81875b57e', '127.0.0.1', 1473799486, '__ci_last_regenerate|i:1473799486;'),
('0d0172c6cacc792bc19509b3e7fe2a924dbbc9d7', '127.0.0.1', 1474470025, '__ci_last_regenerate|i:1474470025;'),
('0d199de83c088635b5fb17553fb1ac755a2b0e02', '127.0.0.1', 1474469473, '__ci_last_regenerate|i:1474469473;'),
('0d392355c0770db2bc6ad166f246467f9cf9f8a1', '127.0.0.1', 1473799545, '__ci_last_regenerate|i:1473799545;'),
('0de3db0d40186350a666d7e566cdc0f9c05ca479', '127.0.0.1', 1472565953, '__ci_last_regenerate|i:1472565758;'),
('0e6ae9fab5329ef5acee1a10225665085153e398', '127.0.0.1', 1473877742, '__ci_last_regenerate|i:1473877742;'),
('0eba41d401144448c851b7de3d0b096e8e1d66cb', '127.0.0.1', 1473799912, '__ci_last_regenerate|i:1473799912;'),
('0f52a1b45943e2674f835c24cb5881d8e294c0fd', '127.0.0.1', 1473772325, '__ci_last_regenerate|i:1473772325;'),
('0fa98f61758ad84ebdb50342cf3821f8cafe4028', '127.0.0.1', 1474549569, '__ci_last_regenerate|i:1474549569;'),
('0fe42387564bfc5bcaa2d684bc628df9695e9bd8', '127.0.0.1', 1473882588, '__ci_last_regenerate|i:1473882588;'),
('105f957d2316a9ef7dbc53a49038734a22c712cb', '127.0.0.1', 1474549647, '__ci_last_regenerate|i:1474549647;'),
('1088b5dd18cd5e60ca9418b55a65765bb85d9d4c', '127.0.0.1', 1473782276, '__ci_last_regenerate|i:1473782276;'),
('10c99fdfc72872b5d1e64d8b95a9fb694c1e9a72', '127.0.0.1', 1473381284, '__ci_last_regenerate|i:1473381284;'),
('10ccd26f87d6009da0ba803128452f6f5dae8abb', '127.0.0.1', 1474549520, '__ci_last_regenerate|i:1474549520;'),
('11581b74ac65195379e4fb6b65d0d38730692491', '127.0.0.1', 1474493202, '__ci_last_regenerate|i:1474493202;'),
('116e7ff496e5b04999b86259377569ac0cfab388', '127.0.0.1', 1474547460, '__ci_last_regenerate|i:1474547460;'),
('11789cc1be3c1942e9d8d901905d055567d29947', '127.0.0.1', 1473886568, '__ci_last_regenerate|i:1473886568;'),
('118d15aede748bf3b44a7f102c4bfeaae1ef80a7', '127.0.0.1', 1473886859, '__ci_last_regenerate|i:1473886859;'),
('11dea73fe5b9fb4e828279af07c03b6a0cd35f8a', '127.0.0.1', 1473774955, '__ci_last_regenerate|i:1473774955;'),
('124d58be1403071324afdcaf1e182235eae4d57f', '127.0.0.1', 1473882550, '__ci_last_regenerate|i:1473882550;'),
('126ff907ebf980fb5b114ba0814598915cac57ea', '127.0.0.1', 1473382410, '__ci_last_regenerate|i:1473382410;'),
('13307ba3bc62b53fbc7a3c80760b4698d1a05745', '127.0.0.1', 1473879880, '__ci_last_regenerate|i:1473879880;'),
('133502e8d6db03639aa7c5ae1d91560975b9ee12', '127.0.0.1', 1474485291, '__ci_last_regenerate|i:1474485291;'),
('135b60d5edb651b7a99fc5f9d3b7bcac676da83b', '127.0.0.1', 1474547320, '__ci_last_regenerate|i:1474547320;'),
('137365d3faebd89b4c8e54703b5ffbb1260d6d3e', '127.0.0.1', 1474484011, '__ci_last_regenerate|i:1474484011;'),
('139a8296d99d53b6569f78b8fbc5dc4bd714326e', '127.0.0.1', 1474550171, '__ci_last_regenerate|i:1474550171;'),
('14e1b6de2c61b639d7c04806e1498b3e36a3689e', '127.0.0.1', 1474549588, '__ci_last_regenerate|i:1474549588;'),
('14fc2ee0fbf98b10cca8f4c1198ae9c8d3e8ffe0', '127.0.0.1', 1474549451, '__ci_last_regenerate|i:1474549451;'),
('151262191617ff92804c4296eaf301b3aa9d1d0f', '192.168.1.164', 1473427000, '__ci_last_regenerate|i:1473427000;'),
('15bc3391e284a27cdecbec7d43431e36a17ab332', '127.0.0.1', 1474550095, '__ci_last_regenerate|i:1474550095;'),
('16530218c7c6a6f15c9f3be4d00749be08e14ca7', '127.0.0.1', 1474469502, '__ci_last_regenerate|i:1474469502;'),
('16c3a8061b416017d497b2e943129b6f05da2dd4', '127.0.0.1', 1474549555, '__ci_last_regenerate|i:1474549555;'),
('16d71f124fc9874dbbf929855e36d28bffdc43bb', '127.0.0.1', 1474549520, '__ci_last_regenerate|i:1474549520;'),
('16e1602b9251ed023562a8bc244cce48858bdeef', '127.0.0.1', 1474549071, '__ci_last_regenerate|i:1474549071;'),
('1773a69e551e136d57a467a2b9fb25a09ebf513f', '192.168.1.164', 1473426950, '__ci_last_regenerate|i:1473426950;'),
('17db5fe5bc7b22355007d8d28f6cd2f5fcc45959', '127.0.0.1', 1473877186, '__ci_last_regenerate|i:1473877186;'),
('17df7ac2fb1ccd29eec64e8547540f9636fbcfdf', '127.0.0.1', 1474549440, '__ci_last_regenerate|i:1474549440;'),
('181cdcf8e09bda26ef3ccfe79b7b75e8d28cc90a', '127.0.0.1', 1474549942, '__ci_last_regenerate|i:1474549942;'),
('185f2ba655935191ba8cdf61fb49c6c59b0dbbed', '127.0.0.1', 1473947955, '__ci_last_regenerate|i:1473947955;'),
('192bfc6708eb4e863281ad984407c01297469383', '127.0.0.1', 1474486466, '__ci_last_regenerate|i:1474486466;'),
('19b807c959502e61a42f215fadd6e55e8c878bb6', '127.0.0.1', 1474550118, '__ci_last_regenerate|i:1474550118;'),
('19c31a51bc3b8cbe9585846d1abd636e70d44ab0', '127.0.0.1', 1473800074, '__ci_last_regenerate|i:1473800074;'),
('19ec5e073a79cb6fe8fad78b5cd6e25d20c30053', '127.0.0.1', 1473948802, '__ci_last_regenerate|i:1473948802;'),
('1a8bfe5a6c2a6e2b3244423fc1c7ddcb3560e2af', '127.0.0.1', 1474549726, '__ci_last_regenerate|i:1474549726;'),
('1aac995ec89888696244cc5e016e341c235fc41f', '127.0.0.1', 1474493270, '__ci_last_regenerate|i:1474493270;'),
('1aebbcc48cd7c926bc1d712e8e3948880f63d7df', '127.0.0.1', 1473886544, '__ci_last_regenerate|i:1473886544;'),
('1be1b8b2b7cae5ae46c2ba50a377384e39c998d5', '127.0.0.1', 1473375215, '__ci_last_regenerate|i:1473375215;'),
('1c12387e17b6cea05459f8bedafa80fa263a9322', '127.0.0.1', 1473883402, '__ci_last_regenerate|i:1473883402;'),
('1c1d1b7dc4bef92eff827439987900b7335ff993', '192.168.1.164', 1473427006, '__ci_last_regenerate|i:1473427006;'),
('1d1a01f059ecf54c02e17f4f13bd75deeb8628c4', '127.0.0.1', 1474549859, '__ci_last_regenerate|i:1474549859;'),
('1e1f951a8276728c05c284d1eda27cc31fa0306a', '127.0.0.1', 1474549588, '__ci_last_regenerate|i:1474549588;'),
('1e824dcade38321574eb604becd48b164c2d4812', '127.0.0.1', 1473772173, '__ci_last_regenerate|i:1473772173;'),
('1ea9f43f533e037ae6deb23f05615085021bf7bf', '127.0.0.1', 1473877442, '__ci_last_regenerate|i:1473877442;'),
('1ef96eb9804a8a9825342d8a92c9c99ddfa9e61b', '127.0.0.1', 1473799643, '__ci_last_regenerate|i:1473799643;'),
('1f6be7d87065d1c14c6366d08b5226589795da64', '192.168.1.133', 1473949273, '__ci_last_regenerate|i:1473949273;'),
('1f75a44b7fe76dbd94153cf96c16142a2dbf6ed9', '127.0.0.1', 1474549569, '__ci_last_regenerate|i:1474549569;'),
('1f7dddcbf8941a8c7056d761d7032361933de87e', '127.0.0.1', 1472572365, '__ci_last_regenerate|i:1472572073;'),
('1fd173ca02c59b0f85392fc178174c75c7e7283b', '127.0.0.1', 1473799784, '__ci_last_regenerate|i:1473799784;'),
('1fff253c9da5a8ea1618228cae0f8d31c7ab5ea5', '127.0.0.1', 1473800507, '__ci_last_regenerate|i:1473800507;'),
('2080d178bea71bff912186e7244ccf81d73d1551', '127.0.0.1', 1473880264, '__ci_last_regenerate|i:1473880264;'),
('2091e6fb3afa8a9d33c4854a27e1eeff55a829a9', '127.0.0.1', 1473878391, '__ci_last_regenerate|i:1473878391;'),
('20947e580704d800b8b79efaadeea25ee520b5cf', '127.0.0.1', 1474486327, '__ci_last_regenerate|i:1474486327;'),
('20947f85ccd3db46e700d322c00538bf88bf41f2', '127.0.0.1', 1473886443, '__ci_last_regenerate|i:1473886443;'),
('209e0b6f3cff4f73194f8ca0258acba5ca7330ca', '127.0.0.1', 1474493187, '__ci_last_regenerate|i:1474493187;'),
('20bffc0eed71586a6d8f3529b342673fdae16417', '127.0.0.1', 1473882537, '__ci_last_regenerate|i:1473882537;'),
('2145830ad899c06b16ca55e9bb09a6c504904722', '127.0.0.1', 1474484636, '__ci_last_regenerate|i:1474484636;'),
('2168fe4decb4d4fc7ad011ce5ccaffb1c3a95ab5', '127.0.0.1', 1473947732, '__ci_last_regenerate|i:1473947732;'),
('21de7e5d69fd90d2cde1887d416302afdf7b62c7', '127.0.0.1', 1474549263, '__ci_last_regenerate|i:1474549263;'),
('220bf8ab57911f624b7e9842cd17d7b2567beb3f', '192.168.1.164', 1473432617, '__ci_last_regenerate|i:1473432616;'),
('2246928965c4df14d9547124054ce29383d9d69f', '127.0.0.1', 1474493121, '__ci_last_regenerate|i:1474493121;'),
('225296795430d63ca3c758561dd1c8c73220afc6', '127.0.0.1', 1473883189, '__ci_last_regenerate|i:1473883189;'),
('228b96ab27a6efdefa3f41ae67893d4936f48e3d', '127.0.0.1', 1473879513, '__ci_last_regenerate|i:1473879513;'),
('22c98a9a9d678db6bf8bd898953f20c9e0fb72dd', '127.0.0.1', 1474468684, '__ci_last_regenerate|i:1474468684;'),
('22df55d49f4a2858276ec1b8e16709fd42a388b1', '127.0.0.1', 1473775556, '__ci_last_regenerate|i:1473775556;'),
('23c5af91e6c87f539a05856e7f3486b0ca0fa272', '127.0.0.1', 1473878132, '__ci_last_regenerate|i:1473878132;'),
('23eae01d58be7a495d1631db310505975ed2bd4c', '127.0.0.1', 1473880804, '__ci_last_regenerate|i:1473880804;'),
('23f99eea372c637285d230f2a10adda3148c1ab6', '127.0.0.1', 1474549689, '__ci_last_regenerate|i:1474549689;'),
('23fa514b02af094717693441466573c230c4d3a8', '127.0.0.1', 1473458400, '__ci_last_regenerate|i:1473458343;'),
('240587850a0c8c480e9afdb12f98cf48595c50d8', '127.0.0.1', 1474470485, '__ci_last_regenerate|i:1474470485;'),
('243348abbe8d9161996e9dc79fb9d9d162d20cb7', '127.0.0.1', 1473883288, '__ci_last_regenerate|i:1473883288;'),
('24d5299c3785ef44bea26c013f554760e77958bc', '127.0.0.1', 1473878131, '__ci_last_regenerate|i:1473878131;'),
('2544145f7f328d1a97a67aeb9259e8703c401f0b', '127.0.0.1', 1474549384, '__ci_last_regenerate|i:1474549384;'),
('2579018a46e56d07df8ffdf76aa895225d5d103a', '127.0.0.1', 1474489036, '__ci_last_regenerate|i:1474489036;'),
('25e88efbd0f2033d59d41a131cf7c9fb94586ceb', '127.0.0.1', 1473880267, '__ci_last_regenerate|i:1473880267;'),
('260b90a2b0a395d5fe4f2a11b9b3a29857b91449', '127.0.0.1', 1474483973, '__ci_last_regenerate|i:1474483973;'),
('268d570ffcab1498c92cf5251a73e4eec78a7dc9', '127.0.0.1', 1473800116, '__ci_last_regenerate|i:1473800116;'),
('26f47cc3de2ffeffde405aaab8088c20a02b83b7', '127.0.0.1', 1473799331, '__ci_last_regenerate|i:1473799331;'),
('270b11ccb97efd3e4c83a1ac5822a1ff6d11fbcd', '127.0.0.1', 1473886580, '__ci_last_regenerate|i:1473886580;'),
('27169d665d51fd39d7dad914a7e167be94f6a2e2', '192.168.1.133', 1473950974, '__ci_last_regenerate|i:1473950972;'),
('2726be7d46c1ea41fa820b221ccdb402f7b8633d', '127.0.0.1', 1474489036, '__ci_last_regenerate|i:1474489036;'),
('277c514ecf4f04d576893f5e13b0b8c331619b8f', '127.0.0.1', 1472572938, '__ci_last_regenerate|i:1472572685;'),
('27c5bbeb7293ac02b9272caae38a9c9a3028d147', '127.0.0.1', 1474493111, '__ci_last_regenerate|i:1474493111;'),
('27c983c39d93a604d66cb2a264c7334012603fae', '127.0.0.1', 1474493064, '__ci_last_regenerate|i:1474493064;'),
('27d73d97483ce052790242927f164cc29bb8e1e1', '127.0.0.1', 1473854053, '__ci_last_regenerate|i:1473854053;'),
('280768231c9b4f0332be8b39039eaccdf3ffbb20', '127.0.0.1', 1474545875, '__ci_last_regenerate|i:1474545875;'),
('281a94c7b3d0f09805ff3b89e666c0a452c820f4', '127.0.0.1', 1473772362, '__ci_last_regenerate|i:1473772362;'),
('285e09242ce3169217b9ae528e0fba032ac470c7', '127.0.0.1', 1474550118, '__ci_last_regenerate|i:1474550118;'),
('28b173afbad9b5ee8c465fafc4144c0226867c26', '127.0.0.1', 1473782111, '__ci_last_regenerate|i:1473782111;'),
('28b5385d64455fd4cc7daaf25ad61c36c59ce23d', '127.0.0.1', 1473880276, '__ci_last_regenerate|i:1473880276;'),
('293c3dd62476e68e9a3258deaf1c80ef433fe078', '127.0.0.1', 1474550105, '__ci_last_regenerate|i:1474550105;'),
('295fd690c7f0d2ea3d76e0544e539a028f7977b2', '127.0.0.1', 1473775511, '__ci_last_regenerate|i:1473775511;'),
('29c4c1813bbe28b5d816c70c53f1921caba1cdbe', '127.0.0.1', 1474550056, '__ci_last_regenerate|i:1474550056;'),
('29ca5e9721435fce76ad619ff341b6981b6ee88c', '127.0.0.1', 1474547552, '__ci_last_regenerate|i:1474547552;'),
('29ea18e38a02dfbe3764ef18e22f4a18868b01fc', '127.0.0.1', 1473799514, '__ci_last_regenerate|i:1473799514;'),
('2a246dc90cb6bc3cac729511708b22920fc08027', '127.0.0.1', 1474493073, '__ci_last_regenerate|i:1474493073;'),
('2a2cb4afc88713872a827c0decdd3ee3a1c4d2f1', '127.0.0.1', 1472573782, '__ci_last_regenerate|i:1472573577;'),
('2a973e19a76bac3285313468710e476aaaf362dd', '127.0.0.1', 1473879816, '__ci_last_regenerate|i:1473879816;'),
('2b1676d009dd5feb0595be500d086b8a06ca05a1', '127.0.0.1', 1473782306, '__ci_last_regenerate|i:1473782306;'),
('2b2832ee8f02b7c04098dc6ff281283b23bc26e0', '127.0.0.1', 1473799308, '__ci_last_regenerate|i:1473799308;'),
('2b4ac05392f82b337c4e3ce0fd5128925911ff38', '127.0.0.1', 1474485127, '__ci_last_regenerate|i:1474485127;'),
('2b6a11931a27c580af3210030e0e66cd8f172dc8', '127.0.0.1', 1473799725, '__ci_last_regenerate|i:1473799725;'),
('2bd524b19d5660bae110df6aa3874802920a065a', '127.0.0.1', 1473886846, '__ci_last_regenerate|i:1473886846;'),
('2be83b63d8ba3e96b584689c221e24f428cdc2fe', '127.0.0.1', 1473458744, '__ci_last_regenerate|i:1473458656;'),
('2c8926ee5cbeca97c8d5ec763968f825e367845c', '127.0.0.1', 1474491703, '__ci_last_regenerate|i:1474491703;'),
('2d005a45d203d60b4e609f045ee33e6efe3fb347', '127.0.0.1', 1473798872, '__ci_last_regenerate|i:1473798872;'),
('2d24d8355739629d65ce9193364fbf427443fd7b', '127.0.0.1', 1473879867, '__ci_last_regenerate|i:1473879867;'),
('2d26f6456944e2ebc96d924151a945f6f3f95213', '127.0.0.1', 1473883179, '__ci_last_regenerate|i:1473883179;'),
('2d4694a63e8332ef53fa8b052b034a2801f3751d', '127.0.0.1', 1473948257, '__ci_last_regenerate|i:1473948257;'),
('2dfd8d93a10d99dd7a8677fd79029983844c1c11', '127.0.0.1', 1474468958, '__ci_last_regenerate|i:1474468958;'),
('2e440ce1f7abda6aabe2d8a3fccb4b178078e0b7', '127.0.0.1', 1474492498, '__ci_last_regenerate|i:1474492498;'),
('2e48aceb1b205c1b6787f3851be16e49d832bc2b', '192.168.1.172', 1473457734, '__ci_last_regenerate|i:1473457734;'),
('2e550b3cada555912948ca2060d10f0561a5b91c', '127.0.0.1', 1474493789, '__ci_last_regenerate|i:1474493789;'),
('2e67e1b4463e58983f8d5ce47f5a07ab532b3d70', '127.0.0.1', 1474493730, '__ci_last_regenerate|i:1474493730;'),
('2eeed84d3e8b0ff2554b5b893e75167162a6c356', '127.0.0.1', 1473948257, '__ci_last_regenerate|i:1473948257;'),
('2efc90cafb09f954c5e4fcbeed48aea08b5f0e68', '192.168.1.133', 1473949289, '__ci_last_regenerate|i:1473949289;'),
('2f038c50edeb3061faac6562ef89a27d1a49d9c2', '127.0.0.1', 1473947311, '__ci_last_regenerate|i:1473947311;'),
('2fe3eb31608bf4b278a060481ef5c0f32a430f8e', '127.0.0.1', 1473775530, '__ci_last_regenerate|i:1473775530;'),
('2feb0d83e81c81e89bea6c7ee7e5e66631f5b1c5', '127.0.0.1', 1474469369, '__ci_last_regenerate|i:1474469369;'),
('3009aae693527eb159b3532cc09017a200ed8923', '127.0.0.1', 1474545877, '__ci_last_regenerate|i:1474545877;'),
('304d635e58937de7d9f4694525d4d6e1400eddd8', '127.0.0.1', 1474547552, '__ci_last_regenerate|i:1474547552;'),
('308a059a02464c00253bd9db660a72f8174feb91', '127.0.0.1', 1474548912, '__ci_last_regenerate|i:1474548912;'),
('30a49ec03ecfac65d32ad3756176d33f1b4bd826', '127.0.0.1', 1473883394, '__ci_last_regenerate|i:1473883394;'),
('30c2f14ef6b22613319347ff7d6fdcbcda3e36fc', '127.0.0.1', 1473800421, '__ci_last_regenerate|i:1473800421;'),
('30dd4e435f1adfd697655b7b411ba430ae58e9d4', '127.0.0.1', 1474547295, '__ci_last_regenerate|i:1474547295;'),
('310ec94cdcbf7a8553608c6b3b9f4f8be8f49a23', '127.0.0.1', 1474469233, '__ci_last_regenerate|i:1474469233;'),
('319cbb954a07765ac93832f843a7a6a92e086608', '127.0.0.1', 1473883315, '__ci_last_regenerate|i:1473883315;'),
('31b4b5d22ed396b57def49e3ffdb1ee8a478bfc1', '192.168.1.164', 1473423891, '__ci_last_regenerate|i:1473423884;'),
('328054436112f04a2964f2b636c3580428a5f764', '192.168.1.164', 1473427674, '__ci_last_regenerate|i:1473427674;'),
('3377554220ad777c4edf1e3746ea847c3f272687', '127.0.0.1', 1473947311, '__ci_last_regenerate|i:1473947311;'),
('338c8568e480fcd945a3c5d1cf59c9a7cb1f9c20', '127.0.0.1', 1473878506, '__ci_last_regenerate|i:1473878506;'),
('33b5bcd2b3042a2f9e259fffc15d6c52f138e368', '127.0.0.1', 1474550098, '__ci_last_regenerate|i:1474550098;'),
('33de35a648cefc6613621ebc0c96f7d1b559617b', '127.0.0.1', 1473880204, '__ci_last_regenerate|i:1473880204;'),
('347c1e4ba8a60dc7579743ff22eb4d41a0546ad0', '127.0.0.1', 1473798872, '__ci_last_regenerate|i:1473798872;'),
('34e81696bea889feb8e4bd01c0ff27a1bf112188', '127.0.0.1', 1474469280, '__ci_last_regenerate|i:1474469280;'),
('3500aa518fc44e83e9f57bd896721576357c019d', '127.0.0.1', 1474549450, '__ci_last_regenerate|i:1474549450;'),
('3563971002752e0a4af15e332ec6268bda29c775', '127.0.0.1', 1473802101, '__ci_last_regenerate|i:1473802101;'),
('357d80bd6bcf651451b1e87683fdb5962551ad84', '127.0.0.1', 1473382301, '__ci_last_regenerate|i:1473382301;'),
('3584d09ad963c633e5b04a57b02f5dec7771e93a', '127.0.0.1', 1473877644, '__ci_last_regenerate|i:1473877644;'),
('35c3d597ec29a1f1189945dd3252057237396c6c', '127.0.0.1', 1473883675, '__ci_last_regenerate|i:1473883675;'),
('3637f81819bed80db94d71847f8ac9b3f9d108c7', '127.0.0.1', 1474550041, '__ci_last_regenerate|i:1474550041;'),
('364097d85f5da8ca2c85126a537669483cd62200', '192.168.1.172', 1473459438, '__ci_last_regenerate|i:1473459438;'),
('3645ea306404540b7eaabcef0535a1f7dbcc8d98', '127.0.0.1', 1473774972, '__ci_last_regenerate|i:1473774972;'),
('367c437b300a3024464c97e10e086214744bc1ea', '192.168.1.172', 1473458213, '__ci_last_regenerate|i:1473458213;'),
('36a8a55c4ce2a2502adb2285de3b293b36e26cd9', '127.0.0.1', 1474549299, '__ci_last_regenerate|i:1474549299;'),
('36db73b3f8cc36ee1b5e5c0f4d4ba89bac066850', '127.0.0.1', 1473879816, '__ci_last_regenerate|i:1473879816;'),
('36fa3625bb754b2ded14b68aba0d395d8a41b8bc', '127.0.0.1', 1474549071, '__ci_last_regenerate|i:1474549071;'),
('3748e11c9e57dbdcdcdceef9b8a31be296f62282', '127.0.0.1', 1474491796, '__ci_last_regenerate|i:1474491796;'),
('376bdbfbd5bb3e6de5beda84c67d8ba327556ff8', '127.0.0.1', 1474486466, '__ci_last_regenerate|i:1474486466;'),
('37b6d1e7d03d88780c1079911ad041c3f794dc1f', '127.0.0.1', 1473882228, '__ci_last_regenerate|i:1473882228;'),
('38000273ee468cc4d11af0afc5944cbd6d37744d', '127.0.0.1', 1473948857, '__ci_last_regenerate|i:1473948857;'),
('380a0c3cb354d908f789c4646d692a1bda8839e3', '127.0.0.1', 1474548432, '__ci_last_regenerate|i:1474548432;'),
('38216b0c2f2a5f12b7460b8d0758b6a09bfc510d', '127.0.0.1', 1473882586, '__ci_last_regenerate|i:1473882586;'),
('3825d5bb382bf1efcfb0fb6c8ed6d85e30204117', '192.168.1.164', 1473432130, '__ci_last_regenerate|i:1473432127;'),
('382dae7e7594b0050818ab72d49deaf15904f031', '127.0.0.1', 1473883179, '__ci_last_regenerate|i:1473883179;'),
('387af29c7610ab1088bfe413906dd6d8947ae424', '127.0.0.1', 1474549549, '__ci_last_regenerate|i:1474549549;'),
('388b3f5eb5747214a2e94556c2349c2f7baea808', '127.0.0.1', 1473802331, '__ci_last_regenerate|i:1473802331;'),
('38bd58b770ea615896b4e8bc19de8c85b5d417f8', '127.0.0.1', 1473886581, '__ci_last_regenerate|i:1473886581;'),
('38daf766aaada8c416b971c745b88a20e546afdb', '127.0.0.1', 1474470609, '__ci_last_regenerate|i:1474470609;'),
('38ecee583c42d859f8a4ee58673e5c613921c171', '127.0.0.1', 1472565726, '__ci_last_regenerate|i:1472565451;'),
('38edf22df1dadb7efbb22a3212d2ef7f12d3f8de', '127.0.0.1', 1474492835, '__ci_last_regenerate|i:1474492835;'),
('392a999f0dfd8c4e720493cdbc29489c123363b4', '127.0.0.1', 1473772301, '__ci_last_regenerate|i:1473772301;'),
('398b8863532b4c99c5a2dde28cb35d1ac28fbe18', '127.0.0.1', 1474492792, '__ci_last_regenerate|i:1474492792;'),
('39b8d5f7cd6e3e9a80095e860897445bff98fc85', '127.0.0.1', 1473877831, '__ci_last_regenerate|i:1473877831;'),
('39c651653d0783e29e5fe52c8f0fce2034170d17', '127.0.0.1', 1474549384, '__ci_last_regenerate|i:1474549384;'),
('3aca015e96d51c0ab73944eb8dc8deade34e8a30', '127.0.0.1', 1473880317, '__ci_last_regenerate|i:1473880317;'),
('3adc45b3d049c65738cc0b07e7bfe9d38947fcce', '127.0.0.1', 1474545924, '__ci_last_regenerate|i:1474545924;'),
('3af76a174c5c36e8733984f042bdc37ff8d37466', '127.0.0.1', 1474469166, '__ci_last_regenerate|i:1474469166;'),
('3b78b079e09038756bc49160d79baeee8f012e5c', '192.168.1.164', 1473429869, '__ci_last_regenerate|i:1473429869;'),
('3b9696376310ee614e14bab1472621c7b0d5d4de', '127.0.0.1', 1472566366, '__ci_last_regenerate|i:1472566366;'),
('3bc8f410223fc29fdd28e61106db65bae45a8a1b', '127.0.0.1', 1474547003, '__ci_last_regenerate|i:1474547003;'),
('3c6c422ae4529edd101004feaa263bdde88f237b', '192.168.1.172', 1474467645, '__ci_last_regenerate|i:1474467645;'),
('3c7b6b30402c3fe8f19f2021926543d4ed14d590', '127.0.0.1', 1474550102, '__ci_last_regenerate|i:1474550102;'),
('3cafd45ef301e592f03cd48d206b4b2ddcd35e99', '127.0.0.1', 1474491780, '__ci_last_regenerate|i:1474491780;'),
('3cb4877c300a548ed94d35042825d4873c2fe036', '127.0.0.1', 1473378324, '__ci_last_regenerate|i:1473378323;'),
('3ccb3fd61bec1305dfebff4468c1e6aab4e2355f', '127.0.0.1', 1474469271, '__ci_last_regenerate|i:1474469271;'),
('3d522d2241e0720d6ec00fe910e8241f61963928', '127.0.0.1', 1474484556, '__ci_last_regenerate|i:1474484556;'),
('3d5866d6e89f88db19ce58da9c596e2e8c922bda', '127.0.0.1', 1473854071, '__ci_last_regenerate|i:1473854071;'),
('3d74cb3a9afe7929c26b34fbe53339b6783ca0bb', '127.0.0.1', 1473774518, '__ci_last_regenerate|i:1473774518;'),
('3d939b150be530655161d1fa711d6fdb96079bef', '192.168.1.164', 1473435751, '__ci_last_regenerate|i:1473435744;'),
('3d98de560ccc30d867535d2b42b662e289ed4486', '127.0.0.1', 1474550105, '__ci_last_regenerate|i:1474550105;'),
('3ed08327527a6fc7496f6184692ecf811c10f5b4', '127.0.0.1', 1474493659, '__ci_last_regenerate|i:1474493659;'),
('3eda7c8031a075b909746dc271a733242940a82b', '127.0.0.1', 1474493243, '__ci_last_regenerate|i:1474493243;'),
('3ef4d06c0f3f7a95c5e6d1daea83bcfccf748152', '127.0.0.1', 1474545790, '__ci_last_regenerate|i:1474545790;'),
('3f1dfcb2736680f0a50a7d6f50ae2d8d1b247f20', '127.0.0.1', 1472495735, '__ci_last_regenerate|i:1472495735;'),
('3f83768f9255534a14d35de789e88bfeeb5feb39', '127.0.0.1', 1474491784, '__ci_last_regenerate|i:1474491784;'),
('4048603250e44544d3eee9ba19b55a9f7055edde', '127.0.0.1', 1473800056, '__ci_last_regenerate|i:1473800056;'),
('4054efcb2c00e23f667b8f36ac0830133a5da484', '127.0.0.1', 1474492821, '__ci_last_regenerate|i:1474492742;'),
('4066fabbf1850610f2d951f386f3dd7aac38d0d1', '127.0.0.1', 1473947736, '__ci_last_regenerate|i:1473947736;'),
('40f0734db01ce51f7bf44cf0e1db50dbc2854a89', '127.0.0.1', 1473879794, '__ci_last_regenerate|i:1473879794;'),
('418c2e6c7ca4da9c568830dece727cdefab96bf2', '127.0.0.1', 1472573196, '__ci_last_regenerate|i:1472573053;'),
('4194a367f719935a7dd7c2ade02326dd739cde3b', '127.0.0.1', 1473876972, '__ci_last_regenerate|i:1473876972;'),
('41a48b4694ca260f1aa02e28e87c236c0ec55acd', '127.0.0.1', 1473877806, '__ci_last_regenerate|i:1473877806;'),
('42117e53bd0a4c75fadac0b8d5fd95ab17cf6187', '127.0.0.1', 1474485127, '__ci_last_regenerate|i:1474485127;'),
('423c11e45a0270462dfbfbd397b33dbda66a00c0', '127.0.0.1', 1473799728, '__ci_last_regenerate|i:1473799728;'),
('4284e2f486f9b3d1835da6efed72d39c399ea4af', '127.0.0.1', 1474484638, '__ci_last_regenerate|i:1474484638;'),
('42c09b0f945027c9c4efd02bb121a360f7ef0618', '127.0.0.1', 1474545136, '__ci_last_regenerate|i:1474545136;'),
('4371d96ff7ba296bf3a9b5bac1cef964b4ec1771', '127.0.0.1', 1473879799, '__ci_last_regenerate|i:1473879799;'),
('43a5f216a65bf100b58fe1ee309bf2cf6705f683', '127.0.0.1', 1473877186, '__ci_last_regenerate|i:1473877186;'),
('443dd920b1aed9d55cbcc4e7dcc103b6616d7582', '127.0.0.1', 1474549846, '__ci_last_regenerate|i:1474549846;'),
('447c064be203f5e33882ebc8257d7ed69bb88934', '127.0.0.1', 1474492792, '__ci_last_regenerate|i:1474492792;'),
('44920b5f039f2114dd7ac6b1f0cd14816f7517ed', '127.0.0.1', 1474488324, '__ci_last_regenerate|i:1474488324;'),
('4537862474f6b997273af2eff8b957b2132ccc88', '127.0.0.1', 1473799728, '__ci_last_regenerate|i:1473799728;'),
('456be8917dc83e71b1e40d01f3242559b27d5f9c', '192.168.1.172', 1473458455, '__ci_last_regenerate|i:1473458455;'),
('45b6d5971c23ec575b69f3d3f953c80c1267ba91', '127.0.0.1', 1473878679, '__ci_last_regenerate|i:1473878679;'),
('4601b142533f4a5a820d515a981da2afe2e0b7d3', '127.0.0.1', 1474549440, '__ci_last_regenerate|i:1474549440;'),
('46618b5a976a43b10ab1df104fd836c9dc3d33f7', '192.168.1.172', 1473459180, '__ci_last_regenerate|i:1473459180;'),
('4728c91dd82cb95bc627afbd38b3b80215a3b55b', '127.0.0.1', 1473880250, '__ci_last_regenerate|i:1473880250;'),
('475a6c50faaf7449fafb4627c4bd76ab815c910d', '127.0.0.1', 1473774711, '__ci_last_regenerate|i:1473774711;'),
('47e98c8e6b68e8a3cc798ce926428313dc4a93dc', '127.0.0.1', 1473947736, '__ci_last_regenerate|i:1473947736;'),
('4804e417a2c014834d85c32b211014912f02fb99', '127.0.0.1', 1473802351, '__ci_last_regenerate|i:1473802351;'),
('4823cd83afd3db31ba045c4023d946da9a9c9d3d', '127.0.0.1', 1474549453, '__ci_last_regenerate|i:1474549453;'),
('4840ffa4f2ccf59c974d3afc1bdaf239ad4c39fd', '127.0.0.1', 1473800354, '__ci_last_regenerate|i:1473800354;'),
('492ae6230e0fc7887f80b67137759683dcaef272', '127.0.0.1', 1474483304, '__ci_last_regenerate|i:1474483304;'),
('4942a068055ec6cbf89ccab10dc2e1e04957d747', '127.0.0.1', 1473799301, '__ci_last_regenerate|i:1473799301;'),
('494de5c0d8ae09a2ba19d4116e939f6f42fbf99d', '192.168.1.172', 1473459614, '__ci_last_regenerate|i:1473459614;'),
('4967875006d6ba30867d2c1c6d78e038b065a2c5', '127.0.0.1', 1474493137, '__ci_last_regenerate|i:1474493137;'),
('496c171f9d994fb5b89f8ade77afdf472ca993c4', '127.0.0.1', 1473378200, '__ci_last_regenerate|i:1473378199;'),
('49a0e7fc1a51ebdfad51eca8bf7e5ae2f99de2f8', '127.0.0.1', 1473883683, '__ci_last_regenerate|i:1473883683;'),
('49cb9560f243af64348f96a2a16005f73d217fab', '127.0.0.1', 1474547382, '__ci_last_regenerate|i:1474547382;'),
('49de39dbb89b3bad3155843b6f48fc2490fe754c', '192.168.1.164', 1473432071, '__ci_last_regenerate|i:1473432071;'),
('4a1900e9d33fe947f6bb2a23f7c5f5b1833cfd96', '127.0.0.1', 1474484627, '__ci_last_regenerate|i:1474484627;'),
('4a3a97354086cd36dc2ac99a73b601515c030e36', '127.0.0.1', 1473878011, '__ci_last_regenerate|i:1473878011;'),
('4a4893b7583a2ac6ff94ed3e52c137a4920539a3', '127.0.0.1', 1474483819, '__ci_last_regenerate|i:1474483819;'),
('4a4e9b9baeef82e3310a9510a40e456a5752a774', '127.0.0.1', 1473947990, '__ci_last_regenerate|i:1473947990;'),
('4ab498c77dbd9aad131c7a32f9c54fcc36f39fc3', '127.0.0.1', 1473774436, '__ci_last_regenerate|i:1473774436;'),
('4aba7c066e778b1d432e398a41f2cacb52e56106', '127.0.0.1', 1473877621, '__ci_last_regenerate|i:1473877621;'),
('4abd2d8f88543664d65c54ff3e6b0b7a6a0da1e6', '127.0.0.1', 1473879526, '__ci_last_regenerate|i:1473879526;'),
('4acfdc49324b206e0426ccc14f7f1b98f3427a36', '127.0.0.1', 1473878679, '__ci_last_regenerate|i:1473878679;'),
('4ad34ca62aacd42251ffa8431f7021e5cf68fc87', '127.0.0.1', 1473772163, '__ci_last_regenerate|i:1473772029;'),
('4ae3eceebda82a5a3bf3f4c136a7e4b1a8285462', '127.0.0.1', 1474549885, '__ci_last_regenerate|i:1474549885;'),
('4ae4900b86d9e3127551e1afc98debea67bf592e', '127.0.0.1', 1473948257, '__ci_last_regenerate|i:1473948257;'),
('4bb41a732f98636855b6a1512d4b2d4755f8f531', '127.0.0.1', 1473948094, '__ci_last_regenerate|i:1473948094;'),
('4d112190591fedfd9720b48a08996df0af997b86', '127.0.0.1', 1474545649, '__ci_last_regenerate|i:1474545649;'),
('4d3c0cb95eface476d3d3cb09e6a6635532b936e', '127.0.0.1', 1473381364, '__ci_last_regenerate|i:1473381364;'),
('4db6160cc5e0af4ad963fc5f952f6f6377dc6881', '127.0.0.1', 1474550101, '__ci_last_regenerate|i:1474550101;'),
('4defc27d801b4d165d10be6290a2bc5c4b341dd5', '127.0.0.1', 1472572674, '__ci_last_regenerate|i:1472572375;'),
('4e0c119941807c4ccbeda509fdd7f579d33b410b', '127.0.0.1', 1473947148, '__ci_last_regenerate|i:1473947148;'),
('4ec53de78a66db37a61ee37471ce00fac15e5170', '127.0.0.1', 1474489256, '__ci_last_regenerate|i:1474489256;'),
('4edc45527125147de364d087df38bcc026c35c48', '127.0.0.1', 1474550141, '__ci_last_regenerate|i:1474550141;'),
('4eec9aabb445220c9e5f29e24cb87fe9df11f46a', '127.0.0.1', 1474486327, '__ci_last_regenerate|i:1474486327;'),
('4ef8be2be542a2e86646801da50e58f2dcd62028', '127.0.0.1', 1473883954, '__ci_last_regenerate|i:1473883954;'),
('4f157fed1d91ab24639c36499efe6057612dc268', '127.0.0.1', 1474547017, '__ci_last_regenerate|i:1474547017;'),
('4f4e3137e4d636a492c2f8a616b8193c67357a26', '127.0.0.1', 1474546503, '__ci_last_regenerate|i:1474546503;'),
('4f6b235e6c2de1e440f298584bbdfaede7c1d7e9', '127.0.0.1', 1473854090, '__ci_last_regenerate|i:1473854090;'),
('4f785ab1be0413c5437c0f17fd96b7b40dba211b', '127.0.0.1', 1473798585, '__ci_last_regenerate|i:1473798585;'),
('4fca7feea3ee8197f339305efd17fa3c89bfa2b0', '127.0.0.1', 1474492636, '__ci_last_regenerate|i:1474492415;'),
('50616f46efd1c21b117c5139fac20f127792bb3e', '127.0.0.1', 1474492219, '__ci_last_regenerate|i:1474491977;'),
('507473dfac62186cd302bd9b239da66d9b934a23', '127.0.0.1', 1474549667, '__ci_last_regenerate|i:1474549667;'),
('50885c1ca67ff2e61c57a5a476810d8c0a82cee4', '127.0.0.1', 1473880204, '__ci_last_regenerate|i:1473880204;'),
('50b0a7fa4da54de99c0b9df3dfff43680c7b097b', '127.0.0.1', 1474547382, '__ci_last_regenerate|i:1474547382;'),
('50c9c87de20393fa4fd272c6eb3edb818dcb2f94', '127.0.0.1', 1474493777, '__ci_last_regenerate|i:1474493776;'),
('51473325268f2cca49a7bf97f2a2d5924950e468', '127.0.0.1', 1473382255, '__ci_last_regenerate|i:1473382255;'),
('51a18b04ef7712424677bae554c167370fc3ea83', '127.0.0.1', 1473797421, '__ci_last_regenerate|i:1473797160;'),
('528220762958b1fcd02ba4e79334d8bd6b41e650', '127.0.0.1', 1474548528, '__ci_last_regenerate|i:1474548528;'),
('52c74398b3e9afa2939522298b9252295eb0434a', '127.0.0.1', 1474550142, '__ci_last_regenerate|i:1474550142;'),
('539645aa3abe96b696c8206f743cbe17bbf66f06', '127.0.0.1', 1474549583, '__ci_last_regenerate|i:1474549583;'),
('53e35c948fa85c1ff8b3136e9094c568e7d822dd', '127.0.0.1', 1474549384, '__ci_last_regenerate|i:1474549384;'),
('53faa0e9a279b7063d0917b6559d2599e3136dc1', '127.0.0.1', 1473948026, '__ci_last_regenerate|i:1473948026;'),
('540466f2073f148524f7ae2e3c4a1b5eea3ad0fa', '192.168.1.133', 1473949283, '__ci_last_regenerate|i:1473949283;'),
('5419047ca24daeead4025c697f311710b761d0dc', '127.0.0.1', 1474493789, '__ci_last_regenerate|i:1474493789;'),
('546d2fa7bd45b67f382b2f470443795240b3db57', '127.0.0.1', 1474550141, '__ci_last_regenerate|i:1474550141;'),
('5476886ffd9abda2a668149dec0e1e32f4ec4fb3', '127.0.0.1', 1474549312, '__ci_last_regenerate|i:1474549312;'),
('547c09b38c91cc8b01f635f7671edd0ac95f7c15', '127.0.0.1', 1473799493, '__ci_last_regenerate|i:1473799493;'),
('552f3c4d560290c0ac9c26016e81352de8175ed1', '127.0.0.1', 1473802213, '__ci_last_regenerate|i:1473802213;'),
('5568a97e43338be9e61a7cf8bc92bc770f693bd9', '127.0.0.1', 1474493193, '__ci_last_regenerate|i:1474493193;'),
('566a635852a83e46489eed53834b8a704dc24657', '127.0.0.1', 1473774941, '__ci_last_regenerate|i:1473774941;'),
('56d5d4904ccd929af88e329e22b8bfb53edc97d1', '127.0.0.1', 1474548528, '__ci_last_regenerate|i:1474548528;'),
('56f51f8f637cea96e1b743428bf31a3b899884d4', '127.0.0.1', 1473800567, '__ci_last_regenerate|i:1473800567;'),
('56f8ae5409023d9c5f0858115ceeb8aacf15739b', '127.0.0.1', 1473886440, '__ci_last_regenerate|i:1473886440;'),
('57032170aaf85daa030d77ba397cbc8c6fa0c984', '127.0.0.1', 1473800069, '__ci_last_regenerate|i:1473800069;'),
('5707376ae956aea6d64413d90bb9123d9987669a', '127.0.0.1', 1473878531, '__ci_last_regenerate|i:1473878531;'),
('57cddcbf81f9d972c7abf2a9c1ce789d7592b16f', '127.0.0.1', 1474549519, '__ci_last_regenerate|i:1474549519;'),
('592ae325037fa0795d3f58ff39a0a5c1560f48f0', '127.0.0.1', 1474488324, '__ci_last_regenerate|i:1474488324;'),
('592f7fc585a561af4d9f29948c0d7f09d2b60f30', '127.0.0.1', 1474484559, '__ci_last_regenerate|i:1474484559;'),
('5957aff1912a444b928c00a60843b5368c0e33a5', '192.168.1.133', 1473948959, '__ci_last_regenerate|i:1473948957;'),
('59db663ff2de49dcdabd802051a1e7ef5f9d47ef', '127.0.0.1', 1472563375, '__ci_last_regenerate|i:1472563355;'),
('5a0fce8126c38aa911a887e9887da06660a66278', '127.0.0.1', 1474549625, '__ci_last_regenerate|i:1474549625;'),
('5a485df6819d85889fedd26d168afbb2b1e19d69', '127.0.0.1', 1473854415, '__ci_last_regenerate|i:1473854415;'),
('5ab3fb91e9f890432ea4ab00fa2a2d1bd6dc313b', '127.0.0.1', 1474470496, '__ci_last_regenerate|i:1474470496;'),
('5ad9055a422f2b2053abd865c97e392aa5d37d8c', '127.0.0.1', 1473799935, '__ci_last_regenerate|i:1473799935;'),
('5b0c04d52f07946f47d8404151d1720829f91651', '127.0.0.1', 1474469587, '__ci_last_regenerate|i:1474469587;'),
('5b438d3212fa30f0cebb168144a7d715e9ed843a', '127.0.0.1', 1474549451, '__ci_last_regenerate|i:1474549451;'),
('5b47dbc80e2219ac3b0d6f3c2e157c2e972c994d', '127.0.0.1', 1473888145, '__ci_last_regenerate|i:1473888145;'),
('5b483c2940aede701543c74c0959f013694731d9', '127.0.0.1', 1473877189, '__ci_last_regenerate|i:1473877189;'),
('5bc224a21883f3d89ed89b437cb459184080bc94', '192.168.1.164', 1473429543, '__ci_last_regenerate|i:1473429543;'),
('5bd2902472b7f57b660e4e4aa8e432cbb3b54878', '127.0.0.1', 1472564938, '__ci_last_regenerate|i:1472564717;'),
('5be774a9f21dc249d62339c1d78f8185c6a6f29f', '127.0.0.1', 1473886759, '__ci_last_regenerate|i:1473886759;'),
('5c2607c60691ffffa517d179b0c4179516eba191', '192.168.1.172', 1474466881, '__ci_last_regenerate|i:1474466881;'),
('5c32a93c9e4561f4f002e3db017f058904dd9494', '127.0.0.1', 1474550305, '__ci_last_regenerate|i:1474550305;'),
('5c78a9b8d690bef064ba41f60d2cbce91a25fcb8', '127.0.0.1', 1473886507, '__ci_last_regenerate|i:1473886507;'),
('5c83b1eb97b947fdf7c074e8511944e07d466c97', '127.0.0.1', 1474493271, '__ci_last_regenerate|i:1474493271;'),
('5d380d9191b143301839128296ca329364ff2367', '127.0.0.1', 1473799291, '__ci_last_regenerate|i:1473799291;'),
('5dd8901980938b42b3108dcd0dc38df241f3f7f5', '127.0.0.1', 1474549107, '__ci_last_regenerate|i:1474549107;'),
('5de4c7470ebaf2b14fb889a03d757f3685eb6668', '127.0.0.1', 1474493258, '__ci_last_regenerate|i:1474493258;'),
('5de8d563e6f39f6b237541fd87b4c897c28d97de', '127.0.0.1', 1473856071, '__ci_last_regenerate|i:1473855823;'),
('5dfcc0b500c4cadbdde36e84af183fa09bf58d41', '127.0.0.1', 1473877750, '__ci_last_regenerate|i:1473877750;'),
('5e0a7c1432799d8e88965c04346604d74ff17931', '127.0.0.1', 1473877389, '__ci_last_regenerate|i:1473877389;'),
('5e652457976338ca49c0bd9c47b86e0c93f81779', '127.0.0.1', 1473877175, '__ci_last_regenerate|i:1473877175;'),
('5eae123aebb5272e33cb97c672fb76493e1fab3b', '127.0.0.1', 1473800734, '__ci_last_regenerate|i:1473800734;'),
('5ee51ada413f61b498ad8ca6ec6dbec3ed1a4466', '127.0.0.1', 1474469474, '__ci_last_regenerate|i:1474469474;'),
('5fb43de0bfd459659607a580b5733ae36136b6d8', '192.168.1.172', 1474467929, '__ci_last_regenerate|i:1474467929;'),
('5fb84fa7b5c456a44cf1d59a8ab0bef3f4a3b167', '127.0.0.1', 1473800228, '__ci_last_regenerate|i:1473800228;'),
('6032aafb834d3a83497c7edb9060d208cad586ab', '127.0.0.1', 1474550118, '__ci_last_regenerate|i:1474550118;'),
('60675a58578ce72055ab11ed683243bec885767e', '127.0.0.1', 1474485601, '__ci_last_regenerate|i:1474485601;'),
('606920069616a8716342b8bbc02159509a038e0e', '127.0.0.1', 1474549726, '__ci_last_regenerate|i:1474549726;'),
('607b110aa0256ab1aa01f08af85b3e43c038b4e3', '127.0.0.1', 1474549667, '__ci_last_regenerate|i:1474549667;'),
('609247b04436a80326840f7a3bb98b0255d8eeba', '127.0.0.1', 1473886440, '__ci_last_regenerate|i:1473886440;'),
('609a94e3fc9951efe593df705615b1431e005772', '127.0.0.1', 1473882537, '__ci_last_regenerate|i:1473882537;'),
('60ace31d10302cb1f46e8ba5cb32bad4ff26e01f', '127.0.0.1', 1473799793, '__ci_last_regenerate|i:1473799793;'),
('60f1037bbb8b7e84bc6b14dd1b9b54fb30f19ff6', '127.0.0.1', 1473382369, '__ci_last_regenerate|i:1473382369;'),
('613118004417a779b2208a25ce922a7afc251191', '127.0.0.1', 1474550102, '__ci_last_regenerate|i:1474550102;'),
('6141f253f19a5ecc326c2e6a48c075e9365c28f3', '127.0.0.1', 1473877946, '__ci_last_regenerate|i:1473877946;'),
('6175d7f978fe4b3af7b919e978d14f292ce1f476', '127.0.0.1', 1473878438, '__ci_last_regenerate|i:1473878438;'),
('626a218a6ffbcbed34b3fb734d116912d14a9b33', '127.0.0.1', 1473947990, '__ci_last_regenerate|i:1473947990;'),
('627ebef70f85d0f6c07a01a49d5e41d959a56b2c', '127.0.0.1', 1474549859, '__ci_last_regenerate|i:1474549859;'),
('62a4c4e3012bf9705b1c9c6e09625a8c898761db', '127.0.0.1', 1474549555, '__ci_last_regenerate|i:1474549555;'),
('62a932d3ca8acf8293e6ddbe1fb32cc9277a587c', '127.0.0.1', 1473878054, '__ci_last_regenerate|i:1473878054;'),
('62c280f6c22f1e960dfaa1e6b4948296078a708a', '127.0.0.1', 1473948041, '__ci_last_regenerate|i:1473948041;'),
('62c42646774f074b95f7606bc706fa71c755e3a3', '127.0.0.1', 1473888097, '__ci_last_regenerate|i:1473888097;'),
('62df339478a5b74264a2c38c15115790a4f1c30e', '127.0.0.1', 1474549549, '__ci_last_regenerate|i:1474549549;'),
('630a4c4b2247b8c82b072cb66675eabbd8b5d661', '127.0.0.1', 1473948349, '__ci_last_regenerate|i:1473948349;'),
('631d48f57aa9c8fbecaff1de7a9821b12f9433b3', '127.0.0.1', 1473947145, '__ci_last_regenerate|i:1473947145;'),
('6325ad4ac0af7db9303f52dd448815c36842d0df', '127.0.0.1', 1473883418, '__ci_last_regenerate|i:1473883418;'),
('63c1db9b0c00691e736e415212c1f43db81c17f6', '127.0.0.1', 1474547159, '__ci_last_regenerate|i:1474547159;'),
('63ce38976ef533a96428c14e8b1dafaaeb323a16', '192.168.1.133', 1473948962, '__ci_last_regenerate|i:1473948962;'),
('651863a6c938a57908f50a65bdd8611e522757b4', '192.168.1.164', 1473432398, '__ci_last_regenerate|i:1473432397;'),
('658ca297a654bdc3ad515d4b5a195e6d5129682c', '127.0.0.1', 1474550171, '__ci_last_regenerate|i:1474550171;'),
('65ca42200ebcedf955beec9d076d839856967ba7', '127.0.0.1', 1473800372, '__ci_last_regenerate|i:1473800372;'),
('665274b6820d4e23b7bc28ef9be652ccbd5538e8', '127.0.0.1', 1473877442, '__ci_last_regenerate|i:1473877442;'),
('66da1742d0c27a34f6937506c77de64c1aa3cdb9', '127.0.0.1', 1473875581, '__ci_last_regenerate|i:1473875413;'),
('66e9e9a0dfb39bd70e95253b85e0365f17596bfe', '127.0.0.1', 1474469587, '__ci_last_regenerate|i:1474469587;'),
('67396d91bf04b833f219e45f4a110c7f6d197df8', '127.0.0.1', 1473774000, '__ci_last_regenerate|i:1473774000;'),
('6747d0cbdec6eb14877d8ca6a6483923c44759ee', '127.0.0.1', 1474469521, '__ci_last_regenerate|i:1474469521;'),
('677e41fe21e5d579f316892fe115220ad0cfcb99', '127.0.0.1', 1473854409, '__ci_last_regenerate|i:1473854409;'),
('67b4296df99790bb5d117c2ca38dc4745a261add', '127.0.0.1', 1474547003, '__ci_last_regenerate|i:1474547003;'),
('67da945c2947a1336b9cf2840c7da889f117a60e', '127.0.0.1', 1473883418, '__ci_last_regenerate|i:1473883418;'),
('67f4537db72cedd411162f464b9ee557ca6fedc8', '127.0.0.1', 1473775361, '__ci_last_regenerate|i:1473775361;'),
('6803537dcea214b720f4e5b0c67aaddbabd2110a', '127.0.0.1', 1474550107, '__ci_last_regenerate|i:1474550107;'),
('6876d24981f796e58daa17d87fd28955098eefe0', '127.0.0.1', 1474493740, '__ci_last_regenerate|i:1474493740;'),
('6984d7fbff5bbf6a7dd7572a74db68500f8fd94f', '127.0.0.1', 1474549625, '__ci_last_regenerate|i:1474549625;'),
('698c9346e67324c9b9bd35bdef78a821f00a9ccd', '127.0.0.1', 1474549474, '__ci_last_regenerate|i:1474549474;'),
('69a99e90b7f580463142540e9c0d901a8e5ce0fb', '127.0.0.1', 1473877810, '__ci_last_regenerate|i:1473877810;'),
('69c447de9a2cabd2592abfca4b74817dc400539e', '127.0.0.1', 1474547552, '__ci_last_regenerate|i:1474547552;'),
('6b4b5e6456a529e8237a703f1ccbef5961e262af', '192.168.1.172', 1473458633, '__ci_last_regenerate|i:1473458633;'),
('6b6d37ecd009fd2f4934e06fed1121bd2d5c3505', '127.0.0.1', 1474546426, '__ci_last_regenerate|i:1474546426;'),
('6b7df0a7c3bc350e911ff9f1434430564ad3ab9f', '127.0.0.1', 1473886440, '__ci_last_regenerate|i:1473886440;'),
('6bd5fa74055da7b719a9da051d9ac8ec130bce0e', '127.0.0.1', 1474545660, '__ci_last_regenerate|i:1474545660;'),
('6bfb0b6df6ce2e1f79f2f07375a971c064627972', '127.0.0.1', 1474550104, '__ci_last_regenerate|i:1474550104;'),
('6c3a783382c9c76730804ac9e38794bdb37770e4', '127.0.0.1', 1473782292, '__ci_last_regenerate|i:1473782292;'),
('6cbebfb715c0dd01b03933281fde092afdc1164c', '127.0.0.1', 1473947840, '__ci_last_regenerate|i:1473947840;'),
('6cd272f6ff6ab63701f8f23c18b23e7aa7fa50b0', '127.0.0.1', 1474493697, '__ci_last_regenerate|i:1474493697;'),
('6d0005356310fcc84e37f07622d662a12d8c4b8a', '127.0.0.1', 1474493718, '__ci_last_regenerate|i:1474493718;'),
('6d1011210ba14cb6b3c1dd7c35b92c0fdc83cee8', '127.0.0.1', 1473377633, '__ci_last_regenerate|i:1473377632;'),
('6da92f3ed8bda17c0b808c2828c935cdaac48a4c', '127.0.0.1', 1474469896, '__ci_last_regenerate|i:1474469896;'),
('6dd8c5653c778286efba23dbc1135afbef0a1e14', '127.0.0.1', 1473886507, '__ci_last_regenerate|i:1473886507;'),
('6dfa77964219ce9e12bc0349ca6baa834ea0eaf6', '127.0.0.1', 1474493645, '__ci_last_regenerate|i:1474493645;'),
('6e11117e13e4e83bf844f2447e40a183ee161d78', '127.0.0.1', 1473885911, '__ci_last_regenerate|i:1473885911;'),
('6eb6be678b7647ce781f5d95473a2249f4d9bae5', '192.168.1.172', 1473458765, '__ci_last_regenerate|i:1473458765;'),
('6edd5fb5f7ae3bf54558b07580b7421501044cd4', '127.0.0.1', 1474485601, '__ci_last_regenerate|i:1474485601;'),
('6f33e97b2808ba25b798b67385f0276ce53bdb66', '127.0.0.1', 1473772233, '__ci_last_regenerate|i:1473772233;'),
('6f73865d4a565f4eb579bc2d0ca96fa41fb0f797', '127.0.0.1', 1473775544, '__ci_last_regenerate|i:1473775544;'),
('6fc13db4d01ebe99bf73b36593d30f90a6514e44', '127.0.0.1', 1473877810, '__ci_last_regenerate|i:1473877810;'),
('6fcf46ccbf750fb4a49bfaa5d5809ea86b84da99', '127.0.0.1', 1474549339, '__ci_last_regenerate|i:1474549339;'),
('6fe394663842cf84f713ade487ee27b92b7183e3', '127.0.0.1', 1474492923, '__ci_last_regenerate|i:1474492923;'),
('7000b13e089bc84ad83fbfee1b725af64cca032a', '127.0.0.1', 1474468744, '__ci_last_regenerate|i:1474468744;'),
('7029fd19c5d3c080ae310da45af9c51212b24ab8', '127.0.0.1', 1474549726, '__ci_last_regenerate|i:1474549726;'),
('70cc20b45ca99c7dcf043bdba75fc28237d0e8a7', '127.0.0.1', 1473886759, '__ci_last_regenerate|i:1473886759;'),
('70d6b85c640f5dcba5d7ef8f9b1b1024977e6ab6', '192.168.1.133', 1473949289, '__ci_last_regenerate|i:1473949289;'),
('70dfb694aaab67826dd41d060b902073f8de60b2', '127.0.0.1', 1473880212, '__ci_last_regenerate|i:1473880212;'),
('71b38ddc894dbfd5c67e3406204f7d45d34e541e', '127.0.0.1', 1474493193, '__ci_last_regenerate|i:1474493193;'),
('720381a6968305a433a620593daf3c1ba0f75108', '192.168.1.164', 1473429520, '__ci_last_regenerate|i:1473429520;'),
('721a1d2906271979712d37472251cc3f4b6263fe', '127.0.0.1', 1474549583, '__ci_last_regenerate|i:1474549583;'),
('7224d4de7a4713b2a17626a02cf28fe28f2392d7', '127.0.0.1', 1474468672, '__ci_last_regenerate|i:1474468672;'),
('723b918a1721a448c5b1f4db1f25522422754a8d', '127.0.0.1', 1474489014, '__ci_last_regenerate|i:1474489014;'),
('72834f7cab7c2c4ac49d5bdd63b4c33219342144', '192.168.1.133', 1473950983, '__ci_last_regenerate|i:1473950983;'),
('72b54d8bb1cd29d5117b172cd950ae24303f6337', '192.168.1.133', 1473950974, '__ci_last_regenerate|i:1473950974;'),
('72e36ccc1395a1db4cf305eb51725d972782d7ec', '192.168.1.133', 1473949282, '__ci_last_regenerate|i:1473949282;'),
('72ee1dee466affb219b8f10efd118ed178062718', '127.0.0.1', 1473877592, '__ci_last_regenerate|i:1473877592;'),
('7394ae2f9a0f42403da4205408320d30f0892b93', '127.0.0.1', 1474549941, '__ci_last_regenerate|i:1474549941;'),
('73a2119ee2736d07d2fbefea4c044349acf895ae', '127.0.0.1', 1474493187, '__ci_last_regenerate|i:1474493187;'),
('740cbc9da5235a679faf6753d1ccbd4d5ed1a7dc', '192.168.1.133', 1473949310, '__ci_last_regenerate|i:1473949310;'),
('7438a339669781a4a0cd73d5f77eb5fa3c92e8c6', '127.0.0.1', 1474549339, '__ci_last_regenerate|i:1474549339;'),
('751adfe8d4d75a5bd56f481e9d7f5e50c4c732bd', '127.0.0.1', 1473947731, '__ci_last_regenerate|i:1473947731;'),
('752dae7b13fb94fe4ca458d994169bdb7c5a1d03', '127.0.0.1', 1474549647, '__ci_last_regenerate|i:1474549647;'),
('75307bd1f4d0791811035407513b77d9d270a1b2', '127.0.0.1', 1474549431, '__ci_last_regenerate|i:1474549431;'),
('755d841ee15b4bd2b745ead27c7d6cf2d00bf4e4', '127.0.0.1', 1473947694, '__ci_last_regenerate|i:1473947694;'),
('7563c76ddd127de33adb4320a40e23ecc96ad70d', '127.0.0.1', 1474549569, '__ci_last_regenerate|i:1474549569;'),
('756d6d53934da7bad24532bb589a8c0ad663c3d9', '127.0.0.1', 1473774487, '__ci_last_regenerate|i:1473774487;'),
('7632406437e2c445adb5553980dd7cd45ea5dea0', '127.0.0.1', 1473948801, '__ci_last_regenerate|i:1473948801;'),
('768d8928d8e221ef6fd9ee419543e54345fa4f9a', '127.0.0.1', 1474547460, '__ci_last_regenerate|i:1474547460;'),
('77155b9063ad78a1cb015c688cfc890949ec4460', '127.0.0.1', 1474493258, '__ci_last_regenerate|i:1474493258;'),
('7715db5bf1d2966dd51b4555b55f0cbea8a137de', '127.0.0.1', 1473947840, '__ci_last_regenerate|i:1473947840;'),
('77609d9bd21ccc2a13ae0b45de5e1b4641e33a22', '127.0.0.1', 1474493121, '__ci_last_regenerate|i:1474493121;'),
('7766d726d01c768259be782e0320c0cedf7d43ca', '127.0.0.1', 1474493740, '__ci_last_regenerate|i:1474493740;'),
('77777db5ed795b3d13d4e767aa77d5884af69abd', '127.0.0.1', 1473880804, '__ci_last_regenerate|i:1473880804;'),
('77ac77f7b3d2644c75f9e5c7db878ec2bc828a5d', '127.0.0.1', 1474549689, '__ci_last_regenerate|i:1474549689;'),
('780549f4db69916ce2a7b75198e023c6e1109147', '127.0.0.1', 1474549455, '__ci_last_regenerate|i:1474549455;'),
('781a489007384b699800c58ff300305e0a4eb121', '127.0.0.1', 1474545927, '__ci_last_regenerate|i:1474545927;'),
('786df7fa0af729c71162d74f6b4385aca66f1a87', '127.0.0.1', 1473947736, '__ci_last_regenerate|i:1473947736;'),
('789b40857dfcc137b43f62edbb475ade8c145e55', '127.0.0.1', 1474485486, '__ci_last_regenerate|i:1474485486;'),
('78caecbf8aef6787f05c9af0e9837c8002e3bc76', '127.0.0.1', 1473880069, '__ci_last_regenerate|i:1473880069;'),
('78e881b09f2ff016e08d579c65241eaac694d3a8', '127.0.0.1', 1474493698, '__ci_last_regenerate|i:1474493698;'),
('799847b69984b44996b718d0c3980fa21b9b69bb', '127.0.0.1', 1473877344, '__ci_last_regenerate|i:1473877344;'),
('79eb7b3e2bb4b2e52ef3f1425b58cb61c4db4540', '127.0.0.1', 1473781530, '__ci_last_regenerate|i:1473781530;'),
('7a154392093f98a819b84ba6662f35925bf41b0f', '127.0.0.1', 1473877344, '__ci_last_regenerate|i:1473877344;'),
('7a49b0de9a51de8913a99e6254f79b6c69ed536f', '127.0.0.1', 1473799545, '__ci_last_regenerate|i:1473799545;'),
('7a4e080b463e0d8e651b858ab9d13c39f8c8226a', '127.0.0.1', 1474545330, '__ci_last_regenerate|i:1474545329;'),
('7ad57f7979ea4f166644d9e620ffea0fe2513f3f', '127.0.0.1', 1473799291, '__ci_last_regenerate|i:1473799291;'),
('7b19bf2925233e326e4cd3a959ed8c52e46e01bf', '127.0.0.1', 1473799331, '__ci_last_regenerate|i:1473799331;');
INSERT INTO `sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('7b2d2d4e211430b6351f29943971552cb6f57b66', '127.0.0.1', 1473886059, '__ci_last_regenerate|i:1473886059;'),
('7b2dc2a7feeb43be8621fbbc6f1a2de86ed2e63f', '192.168.1.133', 1473949189, '__ci_last_regenerate|i:1473949189;'),
('7b5abbf13a0df6ceb912edb8ee8cd457f0b08f9c', '127.0.0.1', 1473886846, '__ci_last_regenerate|i:1473886846;'),
('7b73ede9c2481baa07ec2a6021e801504bb7792a', '127.0.0.1', 1474469369, '__ci_last_regenerate|i:1474469369;'),
('7ba8f2c2b2177e19ed847df5ca02bfcc0dbd29c1', '127.0.0.1', 1474549071, '__ci_last_regenerate|i:1474549071;'),
('7bd34baae5b39b45f8623beccb634e58f760a34d', '127.0.0.1', 1474469739, '__ci_last_regenerate|i:1474469739;'),
('7c061947a44b34a5bb073720c2b5b3c3082cfe32', '127.0.0.1', 1474469593, '__ci_last_regenerate|i:1474469593;'),
('7c69d2b77208904dd388188959d5f9bcbcc7476b', '127.0.0.1', 1473878386, '__ci_last_regenerate|i:1473878386;'),
('7ce8e1718a84674d079d8f476dbfefa8619cb6c9', '127.0.0.1', 1474550107, '__ci_last_regenerate|i:1474550107;'),
('7d0540bf176337eb87697a7684320d9074d0dd78', '127.0.0.1', 1474493441, '__ci_last_regenerate|i:1474493441;'),
('7d1f9602529b51d65b9b3bccc4a3000d6407a919', '127.0.0.1', 1473799967, '__ci_last_regenerate|i:1473799967;'),
('7d8c9f62e83364f1338c8e7cac60175f76c9dced', '127.0.0.1', 1473879942, '__ci_last_regenerate|i:1473879942;'),
('7de68849823d10b3f847d7ba0ca69a40f89cb03a', '127.0.0.1', 1473888097, '__ci_last_regenerate|i:1473888097;'),
('7e65bddad020ccd0604886ee419a1e7d9e29d39d', '127.0.0.1', 1474550095, '__ci_last_regenerate|i:1474550095;'),
('7e75c69a16aff799ddfdadd9f4d47b80032730af', '127.0.0.1', 1474549939, '__ci_last_regenerate|i:1474549939;'),
('7e93a44bd2832cf93ebf34541255ea4264c1ffb1', '127.0.0.1', 1473886544, '__ci_last_regenerate|i:1473886544;'),
('7eee6a9f32f5f44ea139d8b33965ae331b231e85', '127.0.0.1', 1474469383, '__ci_last_regenerate|i:1474469383;'),
('7ef6ef3656544a8117e70386e9e81cfc0d318219', '127.0.0.1', 1473877806, '__ci_last_regenerate|i:1473877806;'),
('7f5d0e558495fd2b723f8e63d7eaf13496868366', '127.0.0.1', 1473883572, '__ci_last_regenerate|i:1473883572;'),
('7fd403540fa51a6476ad357a6b10b8fb49d30645', '127.0.0.1', 1473802204, '__ci_last_regenerate|i:1473802204;'),
('7ffcb83ae42b2d18dc058dd099c51845cd3c92ae', '127.0.0.1', 1474549459, '__ci_last_regenerate|i:1474549459;'),
('802416e7b42441a5fb0c0ad5efdaac7226ff20e9', '127.0.0.1', 1473883403, '__ci_last_regenerate|i:1473883403;'),
('8048f646f245a86f2d036ecb8c85d6d93aea1287', '127.0.0.1', 1474545790, '__ci_last_regenerate|i:1474545790;'),
('8086fd35b55e1d67648855454deefee0f8f67fec', '127.0.0.1', 1473853935, '__ci_last_regenerate|i:1473853935;'),
('81854734836c1da73ff3a1e04961a93fd37fb0d6', '127.0.0.1', 1474549484, '__ci_last_regenerate|i:1474549484;'),
('819e029a89bc6723df470592486921b0e87dc454', '127.0.0.1', 1474545651, '__ci_last_regenerate|i:1474545651;'),
('81ab9ab685523cb94b1c440a8a57594ee264fc47', '127.0.0.1', 1473885911, '__ci_last_regenerate|i:1473885911;'),
('81c423ec64a77432b160abfe6c18b9b8085787fe', '127.0.0.1', 1473878408, '__ci_last_regenerate|i:1473878408;'),
('8219f7f0ae25c6b3c0086f6b611193122044a31e', '127.0.0.1', 1474548528, '__ci_last_regenerate|i:1474548528;'),
('8375d6a3bd03c97c8e7dda556f016363a31c8599', '127.0.0.1', 1474484632, '__ci_last_regenerate|i:1474484632;'),
('839bf3d90d126f73ca7b6d5f5e8130c4e8b2c306', '127.0.0.1', 1474493202, '__ci_last_regenerate|i:1474493202;'),
('83ad63c7c461a37862079c5444e50571fe94b1cc', '127.0.0.1', 1472571450, '__ci_last_regenerate|i:1472571431;'),
('83ee5049857bb660e307e37deabd33bffa654d4d', '127.0.0.1', 1474547143, '__ci_last_regenerate|i:1474547143;'),
('842e15de204a54542aac2124ee2e98c37f54be7a', '192.168.1.172', 1474467649, '__ci_last_regenerate|i:1474467649;'),
('84346f69036fbd9f27b130f38bc00766598667b2', '127.0.0.1', 1474549339, '__ci_last_regenerate|i:1474549339;'),
('8539ba354711f9953ee170ae580e04ed67e031cb', '192.168.1.156', 1474466618, '__ci_last_regenerate|i:1474466617;'),
('85865b634f607415b429136f07d9cfb42cb4b4cb', '127.0.0.1', 1473883288, '__ci_last_regenerate|i:1473883288;'),
('85e07df71068614b2bfd99e2aa8ac78d90d4e695', '127.0.0.1', 1474493776, '__ci_last_regenerate|i:1474493776;'),
('85eb1e45e5af57c1198e470ce39bc8046bfb26e6', '127.0.0.1', 1474549469, '__ci_last_regenerate|i:1474549469;'),
('85fe136d9f2e183cdf5361dafffccd3bbff25aca', '127.0.0.1', 1474549440, '__ci_last_regenerate|i:1474549440;'),
('8699e509f5da7e9e0e4d7b25fb4e58a4db2be979', '127.0.0.1', 1473802721, '__ci_last_regenerate|i:1473802721;'),
('871312cc1e5672a3f35d161b6136b9ba4bafb32f', '127.0.0.1', 1473382404, '__ci_last_regenerate|i:1473382404;'),
('8799c46f7686fd94292eed015ad73861c4f39768', '127.0.0.1', 1473375586, '__ci_last_regenerate|i:1473375585;'),
('87deeca3af29fdcf62e5bd2b8aef6e8daf45d746', '127.0.0.1', 1473948349, '__ci_last_regenerate|i:1473948349;'),
('88034e4cd9c8b2c1657752b3dd27d87bcf0514d0', '127.0.0.1', 1474549647, '__ci_last_regenerate|i:1474549647;'),
('880be20cda68fffb55f1677d966443e9f746b9b8', '127.0.0.1', 1474549469, '__ci_last_regenerate|i:1474549469;'),
('88183692b8ace4e8c678de0a40526e4d7c1daa87', '192.168.1.172', 1474467683, '__ci_last_regenerate|i:1474467683;'),
('882e016c06ac663b99ebf9b547ecaa430276c244', '127.0.0.1', 1474493458, '__ci_last_regenerate|i:1474493458;'),
('882ecf1d2e51d20d5c891ff414bdde3d9644ced9', '127.0.0.1', 1474549625, '__ci_last_regenerate|i:1474549625;'),
('883fe1a46e330f8f3e588a0f27618abb8b3aa999', '127.0.0.1', 1473375211, '__ci_last_regenerate|i:1473375211;'),
('885d7aefff2484002ee65f4c3e89147292f00ada', '127.0.0.1', 1474492923, '__ci_last_regenerate|i:1474492923;'),
('88bfa1380812c74d4cfb78662e4f73086c8845c1', '192.168.1.172', 1473458597, '__ci_last_regenerate|i:1473458597;'),
('88c10e45375284c7bc5d3d382d0b75f4afe3a887', '127.0.0.1', 1474549474, '__ci_last_regenerate|i:1474549474;'),
('88d4bda721cd28b3c1258b5d4f842190b00fd820', '127.0.0.1', 1473877389, '__ci_last_regenerate|i:1473877389;'),
('88ea94f4f256ca1d8186c2e529eb75adabeeeacb', '127.0.0.1', 1473775435, '__ci_last_regenerate|i:1473775435;'),
('893b72add3028bff2b8a989367a4dc4858a697be', '127.0.0.1', 1474550104, '__ci_last_regenerate|i:1474550104;'),
('8944a3bcc6fe3f6f93723d3fc7c8b77e39cbfdd9', '127.0.0.1', 1474547443, '__ci_last_regenerate|i:1474547443;'),
('895666fee23336443f0ba887d3f34758e5b72d39', '127.0.0.1', 1474549924, '__ci_last_regenerate|i:1474549924;'),
('89c71e07728c9ebd1b9f69f3ade9943cd5e28e91', '127.0.0.1', 1473882589, '__ci_last_regenerate|i:1473882589;'),
('8aa323494fa317e43d565eca3750b94ca8c8b005', '127.0.0.1', 1473878386, '__ci_last_regenerate|i:1473878386;'),
('8ae01299a3aa7a66b8d142e0f2f1d18053222cea', '192.168.1.133', 1473948948, '__ci_last_regenerate|i:1473948948;'),
('8b4e679063fa1adf812c3eb348fbf2874f6d1486', '127.0.0.1', 1474493458, '__ci_last_regenerate|i:1474493458;'),
('8bc4e5c009f5c3daaa8616d5be8a792ea69cb17b', '127.0.0.1', 1474547143, '__ci_last_regenerate|i:1474547143;'),
('8d6a4bc63869e6eeaba9ab86e16b5c0e69a5b0ea', '127.0.0.1', 1474489264, '__ci_last_regenerate|i:1474489264;'),
('8d6b872677ce733d28ac494c4c6f22bd92c595b8', '127.0.0.1', 1474550305, '__ci_last_regenerate|i:1474550305;'),
('8d90d7177578bb5041c69558443d1d9363fb1e2b', '127.0.0.1', 1474549549, '__ci_last_regenerate|i:1474549549;'),
('8dc147fd22930241b03e38f0e72e3de70650756b', '127.0.0.1', 1474469499, '__ci_last_regenerate|i:1474469499;'),
('8e5017002a704f61501f33b7c46e129888f39bdd', '127.0.0.1', 1472565385, '__ci_last_regenerate|i:1472565101;'),
('8e980e6a423706f0d4ce856569793b36095d97fe', '127.0.0.1', 1474493645, '__ci_last_regenerate|i:1474493645;'),
('8ee04ff335073ccb181970baa0af04594e719866', '127.0.0.1', 1474485486, '__ci_last_regenerate|i:1474485486;'),
('8f6c09956a097598a2f7aa1dd0a45ad0be00ddb2', '127.0.0.1', 1473854071, '__ci_last_regenerate|i:1473854071;'),
('8f72b0616dd66e880a872f4d69c0550d1e281aaa', '127.0.0.1', 1473799493, '__ci_last_regenerate|i:1473799493;'),
('8fc71d7d0ac20d144cf2b0fd3f41a3a14597bdfe', '127.0.0.1', 1474491780, '__ci_last_regenerate|i:1474491780;'),
('8fe96c25430178ab507b174af4863ce4d8c67f50', '192.168.1.133', 1473949188, '__ci_last_regenerate|i:1473949188;'),
('903761f850d2e29cd46c56c3b135f9bfbed19226', '192.168.1.133', 1473948959, '__ci_last_regenerate|i:1473948959;'),
('9052f041588ebcd456a35117a0d1652b38c5bfb7', '127.0.0.1', 1473880256, '__ci_last_regenerate|i:1473880256;'),
('906ac142a4707679c04683a446963137d6a3ffdd', '127.0.0.1', 1474468743, '__ci_last_regenerate|i:1474468743;'),
('907f015322b66bbaf1e0379ec4542da04c98f4ae', '127.0.0.1', 1473948349, '__ci_last_regenerate|i:1473948349;'),
('90a4c0d435ca4af06bde1d2a31372e601f640e13', '127.0.0.1', 1472593568, '__ci_last_regenerate|i:1472593334;'),
('90b01c3d8d876f9c51f55a761f356a790b174593', '127.0.0.1', 1474469380, '__ci_last_regenerate|i:1474469380;'),
('90b2b2e9383b55e6ad185fe02e0978724921c4e3', '127.0.0.1', 1473883683, '__ci_last_regenerate|i:1473883683;'),
('90f00c31008f5fea7d0f6fafcd201a75cfdb9093', '127.0.0.1', 1473879794, '__ci_last_regenerate|i:1473879794;'),
('91470ba77d5ea0d374360f94505bafda8a2958e1', '127.0.0.1', 1473877432, '__ci_last_regenerate|i:1473877432;'),
('91878b7f40a1adadb61a841fee2432ceac1e1473', '127.0.0.1', 1474469705, '__ci_last_regenerate|i:1474469705;'),
('91fee09bdde3642a6a5209b7f06909493aae5b0c', '127.0.0.1', 1474493718, '__ci_last_regenerate|i:1474493718;'),
('9275f3ca261538b13cd23f3c60accbd15673050f', '127.0.0.1', 1473798585, '__ci_last_regenerate|i:1473798585;'),
('92893fca2602d93ae8f7578ce11d5f33b66753cf', '127.0.0.1', 1474547382, '__ci_last_regenerate|i:1474547382;'),
('92a1fdaf600ffd6062713165f97c259a5201b947', '127.0.0.1', 1473800448, '__ci_last_regenerate|i:1473800448;'),
('92c61a955b4837706d60bec3caf7994827f1c4c3', '127.0.0.1', 1473888097, '__ci_last_regenerate|i:1473888097;'),
('933550fc948e13f3a5af86955965922aff8b242b', '192.168.1.172', 1473770314, '__ci_last_regenerate|i:1473770314;'),
('9341fdb3ead8875bbf328097bd43e679274a143e', '127.0.0.1', 1474488324, '__ci_last_regenerate|i:1474488324;'),
('936abea9de60e6c61866956103fdb031b04c87c3', '127.0.0.1', 1473882586, '__ci_last_regenerate|i:1473882586;'),
('93c5cca4146fa3097295e4c1392acd6817c21efc', '127.0.0.1', 1473854090, '__ci_last_regenerate|i:1473854090;'),
('93e562b521f923c4096b14d1bf9b02fcd9e495e4', '127.0.0.1', 1473883675, '__ci_last_regenerate|i:1473883675;'),
('9486d7f5d10b1efbdb227d9c2b915ea71ddd4fe0', '127.0.0.1', 1473381663, '__ci_last_regenerate|i:1473381485;'),
('94cd86de056ad2d2bfe4689123e2e3b9ed1cee36', '127.0.0.1', 1474470595, '__ci_last_regenerate|i:1474470595;'),
('9524c1e34fc273b9f32d0502aca8604c428194bc', '127.0.0.1', 1473880232, '__ci_last_regenerate|i:1473880232;'),
('9547e17bbe98a63169ca9aa9cfbedc7cd0e87e8c', '127.0.0.1', 1474469225, '__ci_last_regenerate|i:1474469225;'),
('954f157f4da86316d5246049bb85b3a285da5b1d', '127.0.0.1', 1473800153, '__ci_last_regenerate|i:1473800153;'),
('960ff3269e02ac6d0ad7343b840828da182a6dd7', '127.0.0.1', 1472564337, '__ci_last_regenerate|i:1472564107;'),
('962fce0deb3d01a4241523d8277daafad6310717', '127.0.0.1', 1473800233, '__ci_last_regenerate|i:1473800233;'),
('966f738bca8635cd66f6d63ae14938a352c109dc', '192.168.1.164', 1473426860, '__ci_last_regenerate|i:1473426860;'),
('96cbd0b8cc9669a2619e6526ca2164c2f2d910b9', '127.0.0.1', 1473883424, '__ci_last_regenerate|i:1473883424;'),
('971cb069e34ecab6f35c60c47e51d454842bce7c', '127.0.0.1', 1474469218, '__ci_last_regenerate|i:1474469218;'),
('976e41e838e2a697831f7c17cba9181868591c0d', '127.0.0.1', 1473775541, '__ci_last_regenerate|i:1473775541;'),
('97dbdd6e055be425da38387b13df1d6b854b3a74', '127.0.0.1', 1473883424, '__ci_last_regenerate|i:1473883424;'),
('97f595c9158f90e720fcd061628c0c35b1a2b302', '127.0.0.1', 1474549766, '__ci_last_regenerate|i:1474549766;'),
('9831d27ff72ba3b6a6377ac0c94e41187642ab1c', '127.0.0.1', 1473878237, '__ci_last_regenerate|i:1473878237;'),
('98a1caa93f8804c580d94e01a1fc8ac972188d11', '127.0.0.1', 1473883418, '__ci_last_regenerate|i:1473883418;'),
('98d2e234d165183f35d7234628e521ed0698b071', '127.0.0.1', 1473882589, '__ci_last_regenerate|i:1473882589;'),
('9916c87c7747570c05816391b494cdf5e6a8d10f', '127.0.0.1', 1474469476, '__ci_last_regenerate|i:1474469476;'),
('995cfc37ccf1a5c0d917b7801ae97a84a081d188', '127.0.0.1', 1473880276, '__ci_last_regenerate|i:1473880276;'),
('998af4f1000faab055f4539c66e362c8c2f6ea00', '127.0.0.1', 1473882550, '__ci_last_regenerate|i:1473882550;'),
('9a03446807ebb162ea47344a7d37e65360195b28', '127.0.0.1', 1474549667, '__ci_last_regenerate|i:1474549667;'),
('9a7022848c3c995442dc48d999d665b914a78ab9', '127.0.0.1', 1474546655, '__ci_last_regenerate|i:1474546655;'),
('9a90354c72bd1b1f085d262621944d5acea10139', '127.0.0.1', 1474484556, '__ci_last_regenerate|i:1474484556;'),
('9ab202c1b53458ab4870c0f0c711bce68f5306ea', '127.0.0.1', 1473802178, '__ci_last_regenerate|i:1473802178;'),
('9b1f7d67c0bd4ef9aad339ac16f38e7c548b679c', '127.0.0.1', 1474470606, '__ci_last_regenerate|i:1474470606;'),
('9ba5a0b5494a27f9843cca1e626cae65ac56bc47', '127.0.0.1', 1474470579, '__ci_last_regenerate|i:1474470579;'),
('9bbf3e97e2ce6c9db54c11ef1c6c22be54b10719', '127.0.0.1', 1474485291, '__ci_last_regenerate|i:1474485291;'),
('9bed5b38382289e55e63945fb154c87a00055019', '127.0.0.1', 1473772131, '__ci_last_regenerate|i:1473772131;'),
('9bf42a05c59befaecf4b17456e696e32a8270a3c', '192.168.1.172', 1473458770, '__ci_last_regenerate|i:1473458770;'),
('9bf806962bbe16f6d4252de7a9fdca0acde60883', '127.0.0.1', 1473774740, '__ci_last_regenerate|i:1473774740;'),
('9c0bad6e82267a51bb99ac1036a432bc2be29b6c', '127.0.0.1', 1473877644, '__ci_last_regenerate|i:1473877644;'),
('9c1e9de3c52b84827c2cb60d90c40f5b45d3d8fe', '127.0.0.1', 1473799643, '__ci_last_regenerate|i:1473799643;'),
('9c90f1dd8c977545d69b39feddef4563978c4cd9', '127.0.0.1', 1473878682, '__ci_last_regenerate|i:1473878682;'),
('9d5697fe0c899448a99ddecade175556786e3908', '127.0.0.1', 1473799942, '__ci_last_regenerate|i:1473799942;'),
('9da24899fc94b8e26d035dbc27aad80b30b3c95d', '127.0.0.1', 1474545131, '__ci_last_regenerate|i:1474545131;'),
('9de348135741914f978b7c66bfa67c788a84ddbb', '127.0.0.1', 1473799486, '__ci_last_regenerate|i:1473799486;'),
('9e742bee33569b64220c32c266de7e13cbeb0fff', '127.0.0.1', 1474550141, '__ci_last_regenerate|i:1474550141;'),
('9eae0727f380920a0aa1550fd4f20d5ccd052e3a', '127.0.0.1', 1473883288, '__ci_last_regenerate|i:1473883288;'),
('9eae5cbc5fb10c205cc0bca91e774311fc16b38d', '127.0.0.1', 1473877335, '__ci_last_regenerate|i:1473877335;'),
('9ee5c994e8e5b7b96aee5f61151117e390a09963', '127.0.0.1', 1474550008, '__ci_last_regenerate|i:1474550008;'),
('9f1cdcbfb9c206b0f70d67a990414a21e6dfac40', '127.0.0.1', 1473882537, '__ci_last_regenerate|i:1473882537;'),
('9fa3f17000a447ec8d5942d08ceec24c9a5d556e', '127.0.0.1', 1474549484, '__ci_last_regenerate|i:1474549484;'),
('9fd3f09d057180d8bfa2cae1879c7d6194ce2ae2', '192.168.1.172', 1474466964, '__ci_last_regenerate|i:1474466964;'),
('a01d6731fdde086e6483da5ecf3f4e3b48aaaf36', '127.0.0.1', 1474548912, '__ci_last_regenerate|i:1474548912;'),
('a0265d6e1e2355e356cd16e645b7018ab54bdbb8', '127.0.0.1', 1473947695, '__ci_last_regenerate|i:1473947695;'),
('a0680e2784374e3b32d96b82cbc1c1568f4fed26', '127.0.0.1', 1473879513, '__ci_last_regenerate|i:1473879513;'),
('a09116f0c7402e8129f12708fc7c8031561ff8f8', '127.0.0.1', 1473883394, '__ci_last_regenerate|i:1473883394;'),
('a0dfd872b9fef83e4085d5b2878cf7e32ab4838e', '127.0.0.1', 1473432357, '__ci_last_regenerate|i:1473432188;'),
('a12443754a76636d0a75daeaa6740d140e6c4ea8', '127.0.0.1', 1473947840, '__ci_last_regenerate|i:1473947840;'),
('a1847b8337287b1f2c7c2d47fe6ab056cfc97e14', '127.0.0.1', 1473878506, '__ci_last_regenerate|i:1473878506;'),
('a1f21fdb78a4e14743891b3216d451cd3e0e4a5b', '127.0.0.1', 1473877592, '__ci_last_regenerate|i:1473877592;'),
('a21e717ac67c091d783b6a315e98c03fe6eb87cd', '192.168.1.172', 1473459242, '__ci_last_regenerate|i:1473459242;'),
('a2d67e95d956289192d719673bb8e4537693bc68', '127.0.0.1', 1474469344, '__ci_last_regenerate|i:1474469344;'),
('a306abc9d432c5973f23aaeb7a6e5451a070dea0', '127.0.0.1', 1474549583, '__ci_last_regenerate|i:1474549583;'),
('a37f1911eda786c38e032acdeec9b966f4dda6f6', '192.168.1.164', 1473429604, '__ci_last_regenerate|i:1473429604;'),
('a3a397aa2d0aea4f1c6a0bb1567accc46d238d45', '127.0.0.1', 1474550963, '__ci_last_regenerate|i:1474550963;'),
('a3b5670b7721eb1f657845d9738f727d4decf467', '127.0.0.1', 1473799999, '__ci_last_regenerate|i:1473799999;'),
('a4457614df890d089b51953388685040bf8c4eab', '127.0.0.1', 1473886059, '__ci_last_regenerate|i:1473886059;'),
('a49e719dfb9345939a0cfac00e16915a3a8e1bd5', '127.0.0.1', 1473883315, '__ci_last_regenerate|i:1473883315;'),
('a4e2d54e9aed3ab85c0d39cc4a71112e85d51670', '127.0.0.1', 1474550019, '__ci_last_regenerate|i:1474550019;'),
('a523e8e19f4f55f45457203aa3ab484d687a620c', '127.0.0.1', 1473877831, '__ci_last_regenerate|i:1473877831;'),
('a533637d1827c0fd75382e082a67bd5d111f2c81', '127.0.0.1', 1473375207, '__ci_last_regenerate|i:1473375188;'),
('a59d4b52f352a635a8dace1d876e49eaa343c971', '127.0.0.1', 1473880256, '__ci_last_regenerate|i:1473880256;'),
('a626eff9d749a651bb10fe714867cac93a5035e2', '127.0.0.1', 1474546655, '__ci_last_regenerate|i:1474546655;'),
('a652c48c68662c82fe37ffcb379345599f4dad03', '127.0.0.1', 1474549945, '__ci_last_regenerate|i:1474549945;'),
('a657877a4d54fad6afa351d7ce3fb47fefdc144b', '127.0.0.1', 1474483819, '__ci_last_regenerate|i:1474483819;'),
('a712b0875339e842c7c37e6f4c0690090e6fa47a', '127.0.0.1', 1473878531, '__ci_last_regenerate|i:1473878531;'),
('a737f00fcc572e51072c157a69ba4303c6dbd3d4', '127.0.0.1', 1473799840, '__ci_last_regenerate|i:1473799840;'),
('a74555f233b1f73da3885f2c67197d9477ec67b2', '127.0.0.1', 1474549450, '__ci_last_regenerate|i:1474549450;'),
('a78de46cd91e3c2ac789a8465f14138925a706cc', '127.0.0.1', 1474470601, '__ci_last_regenerate|i:1474470601;'),
('a7c3f32ecf15eeac84dd06d1cdf82aaf80959e7a', '127.0.0.1', 1473802724, '__ci_last_regenerate|i:1473802724;'),
('a7e225c0648aa2bd0ee78aaeaab059b92796e5f1', '127.0.0.1', 1473378288, '__ci_last_regenerate|i:1473378287;'),
('a7ea7e990136e09af708388ae84c06230c7f7e62', '127.0.0.1', 1474547160, '__ci_last_regenerate|i:1474547160;'),
('a7f2d4b4c3034caec6ee3151ab1519cda225431e', '127.0.0.1', 1473886544, '__ci_last_regenerate|i:1473886544;'),
('a8bf2c216cfe48f9cfb4978aff5d3b0cbede6be0', '127.0.0.1', 1474483319, '__ci_last_regenerate|i:1474483319;'),
('a9685d3f618a47200774297b6611767a6c1bc4c7', '127.0.0.1', 1473802317, '__ci_last_regenerate|i:1473802317;'),
('a9adf46e2b1d89ce2fbdeae84e49b5e0fb32fce5', '127.0.0.1', 1472572054, '__ci_last_regenerate|i:1472571761;'),
('aa52f1b93f862f7605e83dda5d3b00ab72ffcec8', '192.168.1.164', 1473427125, '__ci_last_regenerate|i:1473427125;'),
('aaa4c572c1062f2d2ca961520524df7b30126897', '127.0.0.1', 1473947990, '__ci_last_regenerate|i:1473947990;'),
('aae35eac2202fad7374ef65f200ba2b35a9a93e3', '127.0.0.1', 1473774573, '__ci_last_regenerate|i:1473774573;'),
('aae5e338c8672dd357bfe22deef4a0b21ec134f0', '127.0.0.1', 1473800434, '__ci_last_regenerate|i:1473800434;'),
('ab4c0b5a879fc470bd9829b535ecaea7a7c83cb2', '127.0.0.1', 1473382038, '__ci_last_regenerate|i:1473382038;'),
('ab834b1d21ef30936f41c6b488348e1e39fac54b', '127.0.0.1', 1473854415, '__ci_last_regenerate|i:1473854415;'),
('abbd63cf5eee1f511750ca9d448a34ad273b9572', '127.0.0.1', 1474548432, '__ci_last_regenerate|i:1474548432;'),
('ac5d6f72efaf86ee9e458a149f48c3e316e0efc9', '127.0.0.1', 1473879942, '__ci_last_regenerate|i:1473879942;'),
('ac8d70f9c9960682db50156a8a0b93805bc7c005', '127.0.0.1', 1474493442, '__ci_last_regenerate|i:1474493442;'),
('ad48854b20c16cfe4091c4954b55ccb49d8715da', '127.0.0.1', 1474549107, '__ci_last_regenerate|i:1474549107;'),
('ad51bd553a8fe638227a9f07bfbb86e90ebda87a', '192.168.1.172', 1473458749, '__ci_last_regenerate|i:1473458749;'),
('adbb55afd1f31bfcce99b04a3c31fce73a4bb07a', '127.0.0.1', 1473877824, '__ci_last_regenerate|i:1473877824;'),
('ae2714c195e40a45e6c3d7026be5e18bde91792b', '127.0.0.1', 1473880212, '__ci_last_regenerate|i:1473880212;'),
('ae2fd82f5f26ee52f326c60919f5282700ae5e57', '127.0.0.1', 1474550098, '__ci_last_regenerate|i:1474550098;'),
('ae64d2894afc71a18137bc961a0b89a0d3560bb3', '127.0.0.1', 1474484632, '__ci_last_regenerate|i:1474484632;'),
('aed52b41c53baca4342e0efefa676ecd217b3ad8', '127.0.0.1', 1473459585, '__ci_last_regenerate|i:1473459522;'),
('af22fabb8c226f8e2885a124af229e46b08232a9', '127.0.0.1', 1473883424, '__ci_last_regenerate|i:1473883424;'),
('af3625a5de92de2dd9d01b09c999c2bc4403a85f', '127.0.0.1', 1474484636, '__ci_last_regenerate|i:1474484636;'),
('b02b1c2177ca22f6c22db9f10550a6cc4449fcbb', '127.0.0.1', 1473799331, '__ci_last_regenerate|i:1473799331;'),
('b0d3239671c750a0a656c71c62a62cfa053327ec', '192.168.1.133', 1473950983, '__ci_last_regenerate|i:1473950983;'),
('b0dca1ba5c1cf621f66ab68063c888e8f93f19ce', '127.0.0.1', 1474483319, '__ci_last_regenerate|i:1474483319;'),
('b0e0edd2e778d804a84605c32e835357afd142bf', '127.0.0.1', 1473888122, '__ci_last_regenerate|i:1473888122;'),
('b134fe7f339f74176069fbcd23c394dbd8692b7e', '127.0.0.1', 1474549924, '__ci_last_regenerate|i:1474549924;'),
('b19bf9f727b84ea1e406415bd514afd8384a1165', '127.0.0.1', 1473883932, '__ci_last_regenerate|i:1473883932;'),
('b24b3b184ca424b3a269d981c51b17103ab29182', '127.0.0.1', 1473882228, '__ci_last_regenerate|i:1473882228;'),
('b27c8de514f52b43cd910c05eb9fb9f043aaf66d', '127.0.0.1', 1473878391, '__ci_last_regenerate|i:1473878391;'),
('b2f62cf596ccb69622167d87d483b043e88fc524', '127.0.0.1', 1474469279, '__ci_last_regenerate|i:1474469279;'),
('b3083800abc32d79d38d6698a5cc8b526ccb97de', '127.0.0.1', 1473802573, '__ci_last_regenerate|i:1473802355;'),
('b3354afcda13e69841e817dedc78e52e2c071808', '127.0.0.1', 1474469278, '__ci_last_regenerate|i:1474469278;'),
('b3505604b289008dbcdb6f387e6c0ce33adb67d0', '127.0.0.1', 1473880317, '__ci_last_regenerate|i:1473880317;'),
('b35773c37671ef63fed88fc3e94b2f780bf8d912', '127.0.0.1', 1473878054, '__ci_last_regenerate|i:1473878054;'),
('b377bb5c97afc2dbc7dcb27f36d6f1c6a554a6f7', '127.0.0.1', 1473800197, '__ci_last_regenerate|i:1473800197;'),
('b3c6a5732a82bd89e73118165e54459738da7a28', '127.0.0.1', 1474550056, '__ci_last_regenerate|i:1474550056;'),
('b404449a2edd2030e6bd16aee043f9c21b21f180', '192.168.1.164', 1473426979, '__ci_last_regenerate|i:1473426979;'),
('b47045ac507b368f76b9de52bad2ecbb4608622f', '127.0.0.1', 1473772914, '__ci_last_regenerate|i:1473772914;'),
('b4c497fd97b19d391e6c1c8caf48d864d7ab5183', '127.0.0.1', 1473948026, '__ci_last_regenerate|i:1473948026;'),
('b4dc100ead9b4a1f3155cd68b64f791a2233a878', '192.168.1.164', 1473430362, '__ci_last_regenerate|i:1473430362;'),
('b4fff51237874e3fdbd94b2c765ae6f5f8bc3703', '192.168.1.133', 1473948962, '__ci_last_regenerate|i:1473948962;'),
('b5597c673f7b34cf4bfa125615f22c6b1c0b0791', '127.0.0.1', 1473776214, '__ci_last_regenerate|i:1473776214;'),
('b5e1335ba7dad8048e13c279938ca4f7b28d7d0e', '127.0.0.1', 1473883954, '__ci_last_regenerate|i:1473883954;'),
('b6094f10575e37cb754b44454aecee226cfd11da', '192.168.1.156', 1474466614, '__ci_last_regenerate|i:1474466614;'),
('b66c0675dc7f3b18d08fa71656ddfcb716d8dc68', '127.0.0.1', 1474547017, '__ci_last_regenerate|i:1474547017;'),
('b67f8f3c5b99597a4ebfab64da8327cb6fa650b5', '127.0.0.1', 1474470574, '__ci_last_regenerate|i:1474470574;'),
('b6e333c944636c81ce768b87361a05495e0b2f7e', '127.0.0.1', 1473800595, '__ci_last_regenerate|i:1473800595;'),
('b6e400d16123367401db0ea250342512993e831d', '127.0.0.1', 1473877825, '__ci_last_regenerate|i:1473877825;'),
('b724691b07a6b7bf92ca7ca7bcafd62ef37aac79', '127.0.0.1', 1474549768, '__ci_last_regenerate|i:1474549768;'),
('b73bb0fccbff5ddf133b7fc151ed16a8ae72e7dd', '192.168.1.156', 1474466619, '__ci_last_regenerate|i:1474466619;'),
('b74a232572fd6752862bf601d78f563126786713', '127.0.0.1', 1473886443, '__ci_last_regenerate|i:1473886443;'),
('b74c4b63607398c51a66cc194e33635d82407819', '127.0.0.1', 1473877621, '__ci_last_regenerate|i:1473877621;'),
('b773e45041dbae9c3bf8d2259fcfe63fb47299ea', '192.168.1.133', 1473949310, '__ci_last_regenerate|i:1473949310;'),
('b859431caa52b25705ff0e40aa03d504e9eb8988', '127.0.0.1', 1473948041, '__ci_last_regenerate|i:1473948041;'),
('b8c49efc3463517857ba839fa1a5b8939f263215', '127.0.0.1', 1474547142, '__ci_last_regenerate|i:1474547142;'),
('b91ad2d722b495a17b48107e07ac6f2c72b04238', '127.0.0.1', 1473880804, '__ci_last_regenerate|i:1473880804;'),
('b968186865303e8b19f8262f86bfd5a75d83d026', '127.0.0.1', 1474549448, '__ci_last_regenerate|i:1474549448;'),
('b970e5e25f2c3ff6a476fdba4d39d447327df4a8', '127.0.0.1', 1473854409, '__ci_last_regenerate|i:1473854409;'),
('b9d2b95d4965855781af08ce2e12233433524197', '127.0.0.1', 1473800685, '__ci_last_regenerate|i:1473800685;'),
('b9e0c32ae770f93f4d07b77e005a11845787d0f2', '192.168.1.133', 1473949189, '__ci_last_regenerate|i:1473949189;'),
('baec1a8035aa07ce11bd80143fff29fdf8983769', '127.0.0.1', 1473802724, '__ci_last_regenerate|i:1473802724;'),
('bb0ea58b9c4ec241dedd8c6934093c193412ee64', '127.0.0.1', 1474492497, '__ci_last_regenerate|i:1474492497;'),
('bc27ea9b4942a467674a7e7d6a03b0d176e78dfa', '127.0.0.1', 1474328103, '__ci_last_regenerate|i:1474328103;'),
('bc6c2453309ccdea985bd3bddb6d96e0d0a7eb04', '127.0.0.1', 1473886806, '__ci_last_regenerate|i:1473886806;'),
('bc6f6fb40ec5259fa13d995b00ce5104eaa9249d', '127.0.0.1', 1474549588, '__ci_last_regenerate|i:1474549588;'),
('bc91bfe34f232e38d2b8b822a8d1a87bc6950e7b', '127.0.0.1', 1474549945, '__ci_last_regenerate|i:1474549945;'),
('bcd0310aac83e1f9e5f540cef1d2273e07b33b9e', '127.0.0.1', 1474546433, '__ci_last_regenerate|i:1474546433;'),
('bd056c388e9cc3234eadbee597cf9bbfb5860a84', '127.0.0.1', 1473879880, '__ci_last_regenerate|i:1473879880;'),
('bd6be8cc758a31f9c38eeeebd4c04bb3ea0cf357', '127.0.0.1', 1473886568, '__ci_last_regenerate|i:1473886568;'),
('be12f40b4d05b5073e0424f5b28566c36c39d185', '127.0.0.1', 1474549846, '__ci_last_regenerate|i:1474549846;'),
('be15a64b1d9ae431c0466e2a9f9358599bc403c7', '127.0.0.1', 1473888145, '__ci_last_regenerate|i:1473888145;'),
('be43ea319b837e4b3509cb171bdc86ad42e915e6', '127.0.0.1', 1473877358, '__ci_last_regenerate|i:1473877358;'),
('be5a1e14f1bb1c8aeabe2a8a88e3fce683632191', '127.0.0.1', 1474484011, '__ci_last_regenerate|i:1474484011;'),
('be79a96c9d153faf45f14c0fa74074a98a5ddc0b', '127.0.0.1', 1473800703, '__ci_last_regenerate|i:1473800703;'),
('bec8f36966047cbdbf0ab0b3ef35f3fb0cc05be1', '127.0.0.1', 1474469707, '__ci_last_regenerate|i:1474469707;'),
('bedc1d0fe6d484cf12a19bb605c63b8aec4bf225', '127.0.0.1', 1474469225, '__ci_last_regenerate|i:1474469225;'),
('c0155095c078823fcf1412decc7f89eab0dce75a', '127.0.0.1', 1474546503, '__ci_last_regenerate|i:1474546503;'),
('c0bdf48683b967a8dd029f2ce44a16f847766e5d', '192.168.1.164', 1473432109, '__ci_last_regenerate|i:1473432109;'),
('c0dcbbf1b685e70663a5451dee99011cc208903f', '127.0.0.1', 1474549455, '__ci_last_regenerate|i:1474549455;'),
('c0e9e962b6c44f11127ce1d3ed7a35804bbd7f0f', '127.0.0.1', 1473799632, '__ci_last_regenerate|i:1473799632;'),
('c12796e65f3526166ebeca49b7cfb15265e97017', '127.0.0.1', 1473772044, '__ci_last_regenerate|i:1473772044;'),
('c1f8fc85c26b24b321f05a190ee3f06257fe34c3', '127.0.0.1', 1473774747, '__ci_last_regenerate|i:1473774747;'),
('c206e5b2f29e61156a2b209db19e2ed52d552320', '127.0.0.1', 1473797742, '__ci_last_regenerate|i:1473797526;'),
('c20c36c79b8ace32c5d6b735bdef61abaacfa5c3', '127.0.0.1', 1473880317, '__ci_last_regenerate|i:1473880317;'),
('c211c68129f6bbb2060467c2d1741ffef1fd5695', '127.0.0.1', 1473878237, '__ci_last_regenerate|i:1473878237;'),
('c22ab48ad1349070591a966d57188398cfca0c8a', '127.0.0.1', 1473378265, '__ci_last_regenerate|i:1473378264;'),
('c23e48ef12cb3546fe6e8c5dabb7dc13d4bab7bc', '127.0.0.1', 1474549537, '__ci_last_regenerate|i:1474549537;'),
('c24a185493833a840368326281c6c905cca3d055', '127.0.0.1', 1473854053, '__ci_last_regenerate|i:1473854053;'),
('c2aaf95df79cbc60c2ba3f9614fc192f444fa8a1', '127.0.0.1', 1473800363, '__ci_last_regenerate|i:1473800363;'),
('c2f0742c54638bae9890ecc2f776ccf95cc9e36f', '127.0.0.1', 1473880267, '__ci_last_regenerate|i:1473880267;'),
('c2f11dfd2cf46d2ce5a8f054dd9fb579cd4ffd57', '127.0.0.1', 1474549474, '__ci_last_regenerate|i:1474549474;'),
('c3461d518ac34100ddf51ed7bb50068d7e78c7d5', '127.0.0.1', 1474549942, '__ci_last_regenerate|i:1474549942;'),
('c3914c78c55c67fc0aad260a1586efd7adef4d6b', '127.0.0.1', 1474549554, '__ci_last_regenerate|i:1474549554;'),
('c3978739a23bc789a782619ee94ee6b35dd29b8a', '127.0.0.1', 1473800570, '__ci_last_regenerate|i:1473800570;'),
('c3a7fa43dd73ac2809717397860b6695cc27260a', '127.0.0.1', 1474486322, '__ci_last_regenerate|i:1474486322;'),
('c3e5df2d5736ce7d4bacd632e02a68c94b5c489e', '127.0.0.1', 1473879578, '__ci_last_regenerate|i:1473879578;'),
('c3e9a998e0d61584557c0a59172fe8d6ca74d193', '127.0.0.1', 1474469870, '__ci_last_regenerate|i:1474469870;'),
('c49004c7d2ba880c5d75b86fcd0ce968c80b0557', '127.0.0.1', 1473880204, '__ci_last_regenerate|i:1473880204;'),
('c537903b0902adb80e57402177b9b81f1ebaa051', '127.0.0.1', 1474549859, '__ci_last_regenerate|i:1474549859;'),
('c60a11c8138c88920f998a7bd5e3c8e84e76bea9', '127.0.0.1', 1473947311, '__ci_last_regenerate|i:1473947311;'),
('c73f237afce94cc8fba953f460befbb66dbb0fcd', '127.0.0.1', 1473882586, '__ci_last_regenerate|i:1473882586;'),
('c7782136189d68a532e682ffad06e2186e8de2ef', '127.0.0.1', 1474549469, '__ci_last_regenerate|i:1474549469;'),
('c78162d792c3583be1f40176f3e2a75ea5abb638', '127.0.0.1', 1473948801, '__ci_last_regenerate|i:1473948801;'),
('c78dce1a93e3f84f8e6d474a3e5af5eb38fc896e', '127.0.0.1', 1474470609, '__ci_last_regenerate|i:1474470609;'),
('c86590b6cd98a313ed66cefd335abf0de6890629', '127.0.0.1', 1474491784, '__ci_last_regenerate|i:1474491784;'),
('c86bce84142bdfb7dcd52789fa1c511d472242fb', '127.0.0.1', 1474550171, '__ci_last_regenerate|i:1474550171;'),
('c8d9f7916f94f0687a86c636d9b33587a879f9f7', '127.0.0.1', 1474549885, '__ci_last_regenerate|i:1474549885;'),
('c8e9e31c52b46f456c900e60ddefad8e64a62001', '127.0.0.1', 1473879880, '__ci_last_regenerate|i:1473879880;'),
('c8f037bfec8c34f3e2c9172341534af41986ce12', '127.0.0.1', 1473880069, '__ci_last_regenerate|i:1473880069;'),
('c95827b7f3068a8da86eb20c6c69d131cc0e832c', '127.0.0.1', 1473878682, '__ci_last_regenerate|i:1473878682;'),
('c9d97bbe62cc5792ac809b0286b99c6e56561e70', '192.168.1.172', 1474466964, '__ci_last_regenerate|i:1474466964;'),
('c9e88d4dd730b05db0204b956515377e758d120c', '127.0.0.1', 1474545666, '__ci_last_regenerate|i:1474545666;'),
('ca47b81a42cfcaf5e467624e083d6a8f15140176', '127.0.0.1', 1473947136, '__ci_last_regenerate|i:1473947136;'),
('cad819ba8e046b0b77c8adfe2ce5872e4f549fbd', '127.0.0.1', 1473947148, '__ci_last_regenerate|i:1473947148;'),
('cb2d183e708a1e9e3adec98a4caeeb2eb2ad0c67', '127.0.0.1', 1474549885, '__ci_last_regenerate|i:1474549885;'),
('cb3273a4d0897fd92613870089d29ba37938d3d7', '127.0.0.1', 1474484627, '__ci_last_regenerate|i:1474484627;'),
('cb6118ac7d8edd90bfde53a5fa0d28c1dd5a009e', '127.0.0.1', 1473880212, '__ci_last_regenerate|i:1473880212;'),
('cb6932b1aa16d226b8ae471b248ff576c4c8de40', '127.0.0.1', 1473883189, '__ci_last_regenerate|i:1473883189;'),
('cb78fe4b76ac630461ec2847f9a0b1bfa12ce197', '127.0.0.1', 1473774584, '__ci_last_regenerate|i:1473774584;'),
('cbdc52179783872eb98e68812f9e1bcc5b6e1457', '192.168.1.172', 1473459378, '__ci_last_regenerate|i:1473459378;'),
('cbf294dde79bb34cce54a9bbf3f49a2f74b0c393', '127.0.0.1', 1474469218, '__ci_last_regenerate|i:1474469218;'),
('cc3be484ada8dc0b6804f1c609b794a26708ac2d', '127.0.0.1', 1473879942, '__ci_last_regenerate|i:1473879942;'),
('cc443759a3a9a1a1d0e47e9d4b844fec3c9d1c47', '127.0.0.1', 1474469729, '__ci_last_regenerate|i:1474469729;'),
('cc9bbc3355b2a02daabc5ed2b066b0c9fc7e340d', '127.0.0.1', 1473799632, '__ci_last_regenerate|i:1473799632;'),
('cce8db76a54c5a671f3bd15ef35023d6ec8d1587', '127.0.0.1', 1474469271, '__ci_last_regenerate|i:1474469271;'),
('ccf1b5b527a8b9430f8a686e2ef0a9b8479a2ba4', '127.0.0.1', 1473883675, '__ci_last_regenerate|i:1473883675;'),
('cd070ac1caf9db58054c6d1d987d4877f26e8be6', '127.0.0.1', 1473880264, '__ci_last_regenerate|i:1473880264;'),
('cd283c3346971ee0f2a4aa6da59bf4582bc71091', '127.0.0.1', 1473948094, '__ci_last_regenerate|i:1473948094;'),
('cd880b5d0f8b5c8f8d0e23c610620eb92b869cb4', '127.0.0.1', 1474485619, '__ci_last_regenerate|i:1474485619;'),
('ce166d9fa30b5f86321af324d2340b691690bce9', '127.0.0.1', 1473883394, '__ci_last_regenerate|i:1473883394;'),
('ce9d63b010ada55655bf3637acdd2d2e8297fe4b', '127.0.0.1', 1474548443, '__ci_last_regenerate|i:1474548443;'),
('cf5e2db12d8c73bcda46a52eb8269100004c6b49', '127.0.0.1', 1474549846, '__ci_last_regenerate|i:1474549846;'),
('cf6157de0f1799dd325dbcd178a763a21844541d', '127.0.0.1', 1474549537, '__ci_last_regenerate|i:1474549537;'),
('cf85e0d5735a2cf20a49454923bcb545447974ab', '127.0.0.1', 1474493074, '__ci_last_regenerate|i:1474493074;'),
('cfac402c5c60828ca8b608fbaabb872639860b20', '127.0.0.1', 1474547460, '__ci_last_regenerate|i:1474547460;'),
('cff66737775a7cee180b845026a3672fa8dffcac', '127.0.0.1', 1473856205, '__ci_last_regenerate|i:1473856136;'),
('d02f0cf4ddf2514bfb200f61192dc2980a0d1b83', '127.0.0.1', 1474547321, '__ci_last_regenerate|i:1474547321;'),
('d0c534b02c09a0712788e3de87915d88c12e0793', '127.0.0.1', 1473854086, '__ci_last_regenerate|i:1473854086;'),
('d0e382c2713ff18a54eee82e6489d98a3b2f17c9', '127.0.0.1', 1474545329, '__ci_last_regenerate|i:1474545329;'),
('d11e4f2d3bf8be3772ab58c9776e770517ddc98f', '127.0.0.1', 1473774625, '__ci_last_regenerate|i:1473774625;'),
('d125a4bf54accd9d398075b0521f30f15c8065c5', '127.0.0.1', 1473877819, '__ci_last_regenerate|i:1473877819;'),
('d13ab1e34b50cebed6be3b3ded67c2c6a6595186', '127.0.0.1', 1473948026, '__ci_last_regenerate|i:1473948026;'),
('d1972b074b53a7248b54aa7b19209acac7c84bbe', '192.168.1.164', 1473426943, '__ci_last_regenerate|i:1473426943;'),
('d2646a54bde541346c157b756a94b4f45232cb2a', '127.0.0.1', 1474549107, '__ci_last_regenerate|i:1474549107;'),
('d27447fafeefc883242a8c59ee9861cf06767a4d', '192.168.1.164', 1473430397, '__ci_last_regenerate|i:1473430397;'),
('d27baad18b7d4710e000bcbe88b7cf0c70b745a4', '127.0.0.1', 1473883682, '__ci_last_regenerate|i:1473883682;'),
('d2a338b6ea3019ef41df25bd6bbfdf5881f1da0a', '127.0.0.1', 1474550174, '__ci_last_regenerate|i:1474550174;'),
('d31198a61e18517e280ba895f37e4af6862fda2b', '127.0.0.1', 1474493243, '__ci_last_regenerate|i:1474493243;'),
('d36e6873c0b9deb9bb46590d2bf2ae37a1f62d4b', '127.0.0.1', 1473771612, '__ci_last_regenerate|i:1473771612;'),
('d3c786b76e6fd71c5c2dce48eb96eaccfe1ace80', '127.0.0.1', 1473883382, '__ci_last_regenerate|i:1473883382;'),
('d3db84cf65b066a887fa7aca8384336436366f52', '127.0.0.1', 1474549484, '__ci_last_regenerate|i:1474549484;'),
('d41158f30bfb92284f48f2476088d2d65623487f', '192.168.1.172', 1473450572, '__ci_last_regenerate|i:1473450572;'),
('d41bfd0d463576b4a0facd06e3b116853a270108', '127.0.0.1', 1473947145, '__ci_last_regenerate|i:1473947145;'),
('d493aa2f0fb899c1488abecedc30f3cfbb80de5c', '127.0.0.1', 1473375217, '__ci_last_regenerate|i:1473375217;'),
('d499008c19c1115768d32a2ebbfc0113402c1c77', '127.0.0.1', 1473872320, '__ci_last_regenerate|i:1473872320;'),
('d4b677a3d60e6df2471a57f7a3085093673d2d95', '127.0.0.1', 1473883189, '__ci_last_regenerate|i:1473883189;'),
('d52769b4920303dda87b177a8b4aa789eafd76f1', '127.0.0.1', 1474469499, '__ci_last_regenerate|i:1474469499;'),
('d53bf8265ba3f6ff0de8089e4568d37dcf4610e2', '127.0.0.1', 1474469380, '__ci_last_regenerate|i:1474469380;'),
('d545a00ba39ce3a7c4ec6984cfca4b71dd72c22b', '127.0.0.1', 1473799514, '__ci_last_regenerate|i:1473799514;'),
('d548a7208ccac650da58bacc8ececcd7de28224a', '127.0.0.1', 1473886059, '__ci_last_regenerate|i:1473886059;'),
('d567c9f9794e87da263377425ef599de18b0361a', '127.0.0.1', 1473886806, '__ci_last_regenerate|i:1473886806;'),
('d5b69085b85142f589151c79ca0d40a4d2bc1f5b', '127.0.0.1', 1474493659, '__ci_last_regenerate|i:1474493659;'),
('d5d4d04c516177f73f15ec2bbdbef88279c3fdfb', '127.0.0.1', 1474492835, '__ci_last_regenerate|i:1474492835;'),
('d5d533a8932dd93089e68a6ac7a0f4ed1778eb61', '127.0.0.1', 1474550035, '__ci_last_regenerate|i:1474550035;'),
('d5e923dfd92f576c1c33c6fec32d68a13f595f01', '127.0.0.1', 1474549941, '__ci_last_regenerate|i:1474549941;'),
('d69b1137db9c34ed0763be3db56b53520cdf3b4a', '127.0.0.1', 1474484006, '__ci_last_regenerate|i:1474484006;'),
('d6b4cf19a08e9339fc845e6df241e574d37172e6', '192.168.1.164', 1473429535, '__ci_last_regenerate|i:1473429535;'),
('d6d760be7d929d855fa8330fabefccfe35c21dd0', '127.0.0.1', 1474486466, '__ci_last_regenerate|i:1474486466;'),
('d720c4781b90752836914cfdf28a530b5a7e40f9', '127.0.0.1', 1474489064, '__ci_last_regenerate|i:1474489064;'),
('d770bb3c172dacd2b38bd8ae5d31dd6c207dabfd', '127.0.0.1', 1473877742, '__ci_last_regenerate|i:1473877742;'),
('d785cbabe26804d1a81f2d4f8490a92c3d74e853', '127.0.0.1', 1473879526, '__ci_last_regenerate|i:1473879526;'),
('d8243866c2db35dcd1452b8e96bbfe161c746e25', '127.0.0.1', 1473381955, '__ci_last_regenerate|i:1473381955;'),
('d8493cb2f458fba9e2c8cf56c330c70a4eb06cdb', '127.0.0.1', 1474545894, '__ci_last_regenerate|i:1474545894;'),
('d853ae4a1dbfd287f60c0f6629f00ec2fc8fab3a', '127.0.0.1', 1473855128, '__ci_last_regenerate|i:1473855128;'),
('d8ad465d262cbc2e198bfd141987685c61cc602a', '127.0.0.1', 1474549076, '__ci_last_regenerate|i:1474549076;'),
('d8d730901c906147d2dc8081a0d2c819aa0d7011', '192.168.1.133', 1473949289, '__ci_last_regenerate|i:1473949289;'),
('d97547bbdba3b76fd002001b63234fcde06f86d1', '127.0.0.1', 1473772053, '__ci_last_regenerate|i:1473772053;'),
('d976f23054a3e3a088d952f695c18e2b3fb5f2ec', '192.168.1.164', 1473432518, '__ci_last_regenerate|i:1473432517;'),
('d997e835318d74f76c7f3764e10be259cb274634', '127.0.0.1', 1474470496, '__ci_last_regenerate|i:1474470496;'),
('d9b5c6ce1d68085a55f953fcdfdb88667294b0d9', '127.0.0.1', 1473886759, '__ci_last_regenerate|i:1473886759;'),
('d9e5229e0f39379e222ccb2a3cc0aec037f560a5', '127.0.0.1', 1473878438, '__ci_last_regenerate|i:1473878438;'),
('da0981af2ec68bbe92c415048027ac0ae8ff3e32', '127.0.0.1', 1473799630, '__ci_last_regenerate|i:1473799630;'),
('dab601c0fb21ed648ba354fe1d9d54a0c399a078', '127.0.0.1', 1474491973, '__ci_last_regenerate|i:1474491973;'),
('db30bec8cd6f27adaf44fc63ec9bdf81a963947e', '127.0.0.1', 1473880068, '__ci_last_regenerate|i:1473880068;'),
('dbcf68b2a125b232c74174afac339a9c0692bebb', '127.0.0.1', 1474493137, '__ci_last_regenerate|i:1474493137;'),
('dbd1b67f77c7a036a351de8cb78593bf6d57646e', '127.0.0.1', 1473774597, '__ci_last_regenerate|i:1473774597;'),
('dc03808a9825523c61853106249bdb36b29db545', '127.0.0.1', 1473781517, '__ci_last_regenerate|i:1473781517;'),
('dc0b56224a855e480d62990c59265a38f28251e9', '127.0.0.1', 1473947695, '__ci_last_regenerate|i:1473947695;'),
('dc3d4667de2595386f5ade15ff71c92684476d9a', '127.0.0.1', 1473774547, '__ci_last_regenerate|i:1473774547;'),
('dc4c674ce7bdc625441785edb3c7545f8c2d62e9', '127.0.0.1', 1474549312, '__ci_last_regenerate|i:1474549312;'),
('dc56bf0c2a5b6e03296ed14b8f20e0f36558eec4', '127.0.0.1', 1474549453, '__ci_last_regenerate|i:1474549453;'),
('dc83570fc6826ad8b449a5da234ca584f72a8632', '127.0.0.1', 1474469165, '__ci_last_regenerate|i:1474469165;'),
('dcbec0e9d3b1897d676e53ecfc2bb05998317c69', '127.0.0.1', 1473883954, '__ci_last_regenerate|i:1473883954;'),
('dcbf85de7b6ba0f219fe9c45c825bcfee474d326', '127.0.0.1', 1473877750, '__ci_last_regenerate|i:1473877750;'),
('dce7a060328c7fbc17d864fb00f3d9b80d79f4f6', '127.0.0.1', 1474470749, '__ci_last_regenerate|i:1474470749;'),
('dd1f943c81b07b1f40f364770d215232368c0df9', '127.0.0.1', 1473381985, '__ci_last_regenerate|i:1473381985;'),
('ddb1d84cda9c135eeedee73956c3acef8dcf1dee', '127.0.0.1', 1473853935, '__ci_last_regenerate|i:1473853935;'),
('ddef80ef004530ee82da0fdb976a2bc9de72bc51', '127.0.0.1', 1474550095, '__ci_last_regenerate|i:1474550095;'),
('ddf0a4e3cb63050b151ac7be1e0ddbcf59fdf11f', '127.0.0.1', 1473877683, '__ci_last_regenerate|i:1473877683;'),
('de08074b37a018db8290baf3da5e7501a453319f', '192.168.1.172', 1473459407, '__ci_last_regenerate|i:1473459407;'),
('dea781dd1903d98f930e87cc27b358df663bf70e', '127.0.0.1', 1474550173, '__ci_last_regenerate|i:1474550173;'),
('dee35a53fb242d3bb7f0425d2da128e99091e2e7', '127.0.0.1', 1473772137, '__ci_last_regenerate|i:1473772137;'),
('df0faa1bad67251391252b97952163ecb4173e84', '127.0.0.1', 1474550035, '__ci_last_regenerate|i:1474550035;'),
('df65f4c84d52d5743229ead9561fa599a7349004', '127.0.0.1', 1473773995, '__ci_last_regenerate|i:1473773697;'),
('dfb363ce87502bee4bede503cd0b7df5fd7c6bac', '127.0.0.1', 1473854097, '__ci_last_regenerate|i:1473854097;'),
('dfd117bf37ab11d23551d736165b9df27119da76', '127.0.0.1', 1473883382, '__ci_last_regenerate|i:1473883382;'),
('e09253243877f0356c5c3ddb19a31932fea95672', '127.0.0.1', 1474470120, '__ci_last_regenerate|i:1474470120;'),
('e0d714daf76065b430547ff7d77fb5d7fe8b97c6', '127.0.0.1', 1474468620, '__ci_last_regenerate|i:1474468620;'),
('e11a27283079a00fd00e40c5207a5566b081957b', '127.0.0.1', 1473774695, '__ci_last_regenerate|i:1473774695;'),
('e14bf65d1d2d544b739d6632cdf1039eb6adf6fb', '127.0.0.1', 1473880232, '__ci_last_regenerate|i:1473880232;'),
('e15a6bd5e8b17ca353223a87a6fc5854ae8b3943', '127.0.0.1', 1473800481, '__ci_last_regenerate|i:1473800481;'),
('e1a263431eb642c81ab5196b532e660196045892', '127.0.0.1', 1473799895, '__ci_last_regenerate|i:1473799895;'),
('e1c78d2ef9a32e61d3bbc185b1df72784fb4efcf', '127.0.0.1', 1473799301, '__ci_last_regenerate|i:1473799301;'),
('e1cbb09628811afa161f379410dcab1d9d3f4324', '127.0.0.1', 1473774820, '__ci_last_regenerate|i:1473774820;'),
('e1e5eb906128fe07ac8ea53f73138e6f35d07dce', '127.0.0.1', 1474549431, '__ci_last_regenerate|i:1474549431;'),
('e30ad2cdd4078435096ec0413a75b0d9c2ef9b22', '127.0.0.1', 1474549263, '__ci_last_regenerate|i:1474549263;'),
('e32873308dc2af0829d531c189b753ba3f58288c', '127.0.0.1', 1474547442, '__ci_last_regenerate|i:1474547442;'),
('e33ddcf19d5d2b8bc95811fd86d65740b9c25c26', '127.0.0.1', 1473800205, '__ci_last_regenerate|i:1473800205;'),
('e3627eba957f9b006a690bbb579bf3062a05b4c2', '127.0.0.1', 1473782306, '__ci_last_regenerate|i:1473782306;'),
('e43d81529234cee97626835bff3d5945021c49ab', '127.0.0.1', 1474468622, '__ci_last_regenerate|i:1474468622;'),
('e4589815fbf17f7e00a7fd6f5303d1b9e36d012a', '127.0.0.1', 1474548443, '__ci_last_regenerate|i:1474548443;'),
('e496309725be022d60bae88a067a6e467cc0c444', '127.0.0.1', 1474469233, '__ci_last_regenerate|i:1474469233;'),
('e55306601004ddd76a17c8c3b4cd57b943a9e357', '127.0.0.1', 1473802351, '__ci_last_regenerate|i:1473802351;'),
('e579e349cbb8c30c661fe9cfe652d22fb6ecf7c3', '127.0.0.1', 1473879794, '__ci_last_regenerate|i:1473879794;'),
('e5eb08a3ae246a42a3772612e91d0e6cdb662081', '127.0.0.1', 1474547017, '__ci_last_regenerate|i:1474547017;'),
('e65fb28fb566467c0e47cbfa3563acea2aab9c26', '127.0.0.1', 1474549299, '__ci_last_regenerate|i:1474549299;'),
('e6acaa88c271297e794251f16b09c6440c0bbf4b', '127.0.0.1', 1474470157, '__ci_last_regenerate|i:1474470157;'),
('e6e03304f89f3494bdde7f9a15fbccb85698d787', '127.0.0.1', 1474548912, '__ci_last_regenerate|i:1474548912;'),
('e7924da1217f218189e753e7eb5e4eeededfde96', '127.0.0.1', 1473886803, '__ci_last_regenerate|i:1473886803;'),
('e7aff3c57ef3e7f62891526ece8a4eba60eaa60a', '192.168.1.164', 1473432021, '__ci_last_regenerate|i:1473432021;'),
('e81bbc7c8759cb6e86acc426e9b8e9a8166447a5', '127.0.0.1', 1473879927, '__ci_last_regenerate|i:1473879927;'),
('e8b520d9464f37a75b1002f45a9b2e7f2b50da61', '127.0.0.1', 1473883932, '__ci_last_regenerate|i:1473883932;'),
('e8c91f1e1765dc9b2bc5c8011d2211e0be9d4b22', '127.0.0.1', 1474468681, '__ci_last_regenerate|i:1474468681;'),
('e8dfde4f10fc5dd374f6e41d1b2ad82f2b763252', '127.0.0.1', 1473880250, '__ci_last_regenerate|i:1473880250;'),
('e9bc8fd139333aec7ff27f5cd766e9fece6044e1', '192.168.1.172', 1473458606, '__ci_last_regenerate|i:1473458606;'),
('e9c1c61a3039c317fb6aa34a7ee0464c825f261e', '192.168.1.164', 1473429664, '__ci_last_regenerate|i:1473429664;'),
('ea42bea04597ba3ba0fac8da06b055539b691ad5', '127.0.0.1', 1473800064, '__ci_last_regenerate|i:1473800064;'),
('eab26d33b02f92e9c339279acf7b7fff71458704', '127.0.0.1', 1474547295, '__ci_last_regenerate|i:1474547295;'),
('eae082e0a0392c9b7124e04166bc55ce7ff26102', '192.168.1.164', 1473427668, '__ci_last_regenerate|i:1473427668;'),
('eb6ed65b2e499ac92a6331d1e9cb10de88155954', '127.0.0.1', 1473883382, '__ci_last_regenerate|i:1473883382;'),
('eb7e4b93e8ff8c036faa569a1b30f6a02c84f7f0', '127.0.0.1', 1474549924, '__ci_last_regenerate|i:1474549924;'),
('eb95613a47c1ccb7221a641e9a229a8b281e7d41', '127.0.0.1', 1473802250, '__ci_last_regenerate|i:1473802250;'),
('ebad1a91a817b904e8f22ca90c35bb92ff0d3b2b', '192.168.1.172', 1473948949, '__ci_last_regenerate|i:1473948949;'),
('ec0a2ab756e22e05b64a02f851a0e1238ca1544f', '127.0.0.1', 1474549537, '__ci_last_regenerate|i:1474549537;'),
('ec4aa1b9999036b94b09650bfc5a2b41a0344e5f', '127.0.0.1', 1474545879, '__ci_last_regenerate|i:1474545879;'),
('ec6d2fb02da3659676f582fc54c7b6cac2667543', '192.168.1.164', 1473426973, '__ci_last_regenerate|i:1473426973;'),
('ecc3b5406eab49776f1f619ba4d32e541d4abaaf', '127.0.0.1', 1473879815, '__ci_last_regenerate|i:1473879815;'),
('ecf3ab7d3e6e11e3d64870452505133624e9eeb9', '127.0.0.1', 1474549311, '__ci_last_regenerate|i:1474549311;'),
('ecfd6afaf6bf04d5976c2be77a79022eb136643a', '127.0.0.1', 1473854086, '__ci_last_regenerate|i:1473854086;'),
('edaeed739e49ae0404b5aab70705536381b923dd', '127.0.0.1', 1473381860, '__ci_last_regenerate|i:1473381860;'),
('edbfc26a3ca725231db1305b8049c1c0dfc8d538', '127.0.0.1', 1474549689, '__ci_last_regenerate|i:1474549689;'),
('edc2acda8e3f2b840f43a44f005c6e2b4b4a8693', '127.0.0.1', 1473878013, '__ci_last_regenerate|i:1473878013;'),
('eddbcf72dc6a3404159a4cbbb4c74fe144c73162', '127.0.0.1', 1473775192, '__ci_last_regenerate|i:1473775192;'),
('ede7634a93bf7071dd55460f8d94eb15bbc3be3f', '192.168.1.172', 1473458420, '__ci_last_regenerate|i:1473458420;'),
('ee97b50db540ed3faa2f55c57baa281fa3c07d59', '127.0.0.1', 1474493730, '__ci_last_regenerate|i:1474493730;'),
('eee731d1e4cd84e7c5530e089d9ea604c7f0d478', '192.168.1.133', 1473949273, '__ci_last_regenerate|i:1473949273;'),
('ef56f5af1e26a38d6fa58a55c0d248b0dc971788', '127.0.0.1', 1473883572, '__ci_last_regenerate|i:1473883572;'),
('f0325b18d09cc7f893d8467c39da05e24e5da837', '127.0.0.1', 1474550053, '__ci_last_regenerate|i:1474550053;'),
('f04395215fe35c3d594de1b6ff0812b92d598ec0', '127.0.0.1', 1474549459, '__ci_last_regenerate|i:1474549459;'),
('f045f12de18f91b8335bd3fa4f60a4fd7d3e08dd', '127.0.0.1', 1473799630, '__ci_last_regenerate|i:1473799630;'),
('f0946a40b382f671c72b411f73095f1a08e7e7d6', '127.0.0.1', 1473888122, '__ci_last_regenerate|i:1473888122;'),
('f0af7001fed555e5f06a21f091fb06012a0ef99f', '127.0.0.1', 1473877683, '__ci_last_regenerate|i:1473877683;'),
('f0c1efae07aff573bf2d95a2b80138c99a0f10e4', '127.0.0.1', 1473882228, '__ci_last_regenerate|i:1473882228;'),
('f1cb70a9a3fbe54cbec65ab400ce304143874109', '127.0.0.1', 1473798872, '__ci_last_regenerate|i:1473798872;'),
('f1f71e0e6e70ddb7d54aa94be5c216a0daf3d7fe', '127.0.0.1', 1473378339, '__ci_last_regenerate|i:1473378338;'),
('f26874dc717073c03e0b17032f7082945cd08c5e', '127.0.0.1', 1474548443, '__ci_last_regenerate|i:1474548443;'),
('f29d08b1432edb74bca6934e92842cd79d457740', '127.0.0.1', 1474549939, '__ci_last_regenerate|i:1474549939;'),
('f2cdb702cc84e75963d0846c7ee8b101633bc551', '127.0.0.1', 1474548432, '__ci_last_regenerate|i:1474548432;'),
('f2e4848473459f2f6fb21a439531360edb0feb9c', '127.0.0.1', 1473878408, '__ci_last_regenerate|i:1473878408;'),
('f34b1343485f9082f3c2e75535246ddfa46b3529', '127.0.0.1', 1474470137, '__ci_last_regenerate|i:1474470137;'),
('f3531b0a34c1b4cb5b87e583200e70cb3c660d9d', '127.0.0.1', 1473854097, '__ci_last_regenerate|i:1473854097;'),
('f3783b9c46eb743def8f00018fccbd0c1018ae03', '127.0.0.1', 1473458041, '__ci_last_regenerate|i:1473457965;'),
('f3a86fc3f23ed049d0133a7541bb7040af903052', '127.0.0.1', 1473880250, '__ci_last_regenerate|i:1473880250;'),
('f3b07745d743d51966c4be8a0cb0d38453857e66', '127.0.0.1', 1474549768, '__ci_last_regenerate|i:1474549768;'),
('f4075b96de11e8884140973ded386d28348c785c', '127.0.0.1', 1474550142, '__ci_last_regenerate|i:1474550142;'),
('f4245fb79bccdb1ff52c531a8aaa2803673a9eb4', '127.0.0.1', 1473883179, '__ci_last_regenerate|i:1473883179;'),
('f462e58fb5c946f6c1a66df2f7d3eefb0a5ccc66', '127.0.0.1', 1473883403, '__ci_last_regenerate|i:1473883403;'),
('f4dc4f67322318bfd4abfefca522fe2e141c7cde', '127.0.0.1', 1474483767, '__ci_last_regenerate|i:1474483767;'),
('f5127b34326f5a8b0039e8121b630aa7786f6f9f', '127.0.0.1', 1473877359, '__ci_last_regenerate|i:1473877359;'),
('f5ad3baffd1bb460ea60bff8146d8321a7db1664', '127.0.0.1', 1474469241, '__ci_last_regenerate|i:1474469241;'),
('f5b876df7ecd5020c5dbc73ac2734d56cebfce40', '127.0.0.1', 1474549431, '__ci_last_regenerate|i:1474549431;'),
('f5c9aed2c1c0a8d83b87d1e693da852e3994f30b', '127.0.0.1', 1474549448, '__ci_last_regenerate|i:1474549448;'),
('f5e817cf8729b20092f87de82536b640c18d8ae0', '127.0.0.1', 1474469705, '__ci_last_regenerate|i:1474469705;'),
('f5ef2990ce6037d789d4f3063ff6439bd0d021f7', '127.0.0.1', 1473802642, '__ci_last_regenerate|i:1473802642;'),
('f682f188f02f2ac413685c7c1869c5d381300771', '127.0.0.1', 1473885913, '__ci_last_regenerate|i:1473885913;'),
('f68e8c45ebdcbbe3d736c966297ed48accc93580', '127.0.0.1', 1473886567, '__ci_last_regenerate|i:1473886567;'),
('f71a0fbd17b7930326fc93d80af62235ea506d21', '127.0.0.1', 1473800626, '__ci_last_regenerate|i:1473800626;'),
('f81144a41e1f4b11c695ec19e1f06e89c60c44bd', '127.0.0.1', 1473877819, '__ci_last_regenerate|i:1473877819;'),
('f8581bfdfeab00544c17fb52d049195f648e640a', '127.0.0.1', 1474549766, '__ci_last_regenerate|i:1474549766;'),
('f8708c114ca3c9dfeca6d73db0c759cf14b2e852', '127.0.0.1', 1474480640, '__ci_last_regenerate|i:1474480423;'),
('f8d7c5edc4010a597553dee95379f4631be0a712', '127.0.0.1', 1473885911, '__ci_last_regenerate|i:1473885911;'),
('f8d85ee7ae1a6dbcd20698c08b71640c2e3bf27e', '127.0.0.1', 1473800147, '__ci_last_regenerate|i:1473800147;'),
('f8f519d76273c22456bb564557953555513827c4', '127.0.0.1', 1473888145, '__ci_last_regenerate|i:1473888145;'),
('f92a330f198985e9de4a83cb7a252be2a74b6d62', '127.0.0.1', 1473880267, '__ci_last_regenerate|i:1473880267;'),
('f95446fb43dce71ea8d3801e4459c5ea8471674d', '127.0.0.1', 1473882550, '__ci_last_regenerate|i:1473882550;'),
('f958b0c0f411004c777f091a0281ddacb89973ac', '127.0.0.1', 1473382324, '__ci_last_regenerate|i:1473382324;'),
('f9c34ff2c1c8933d77cc36285eb478d0253cab20', '127.0.0.1', 1473782107, '__ci_last_regenerate|i:1473782107;'),
('f9f234c61b21c3d6c15cd29cb61e5f2a381a52b6', '127.0.0.1', 1473948041, '__ci_last_regenerate|i:1473948041;');
INSERT INTO `sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('fa0a49119eb7516afbd28c8e395de46172c52c4a', '127.0.0.1', 1474469552, '__ci_last_regenerate|i:1474469552;'),
('fa3236d826a5e2cb29e522d660209dd362037d24', '127.0.0.1', 1473855659, '__ci_last_regenerate|i:1473855429;'),
('fac681eb8bc1448d413f4ef19ea54db575be6236', '127.0.0.1', 1473883572, '__ci_last_regenerate|i:1473883572;'),
('fac984105aeb11c28498a68d930da01fe3e7ef81', '127.0.0.1', 1473877432, '__ci_last_regenerate|i:1473877432;'),
('fc61c875ebb2d346a6d7be423539d7c23ec14801', '127.0.0.1', 1473879578, '__ci_last_regenerate|i:1473879578;'),
('fc73bbf80175f7ec2612c5fb7065cc55f97ac401', '127.0.0.1', 1474470577, '__ci_last_regenerate|i:1474470577;'),
('fc7711aceac3d348e3c5f39ba256f9c895be5c5e', '127.0.0.1', 1474469744, '__ci_last_regenerate|i:1474469744;'),
('fce8031036a4ff8f84e444c002905a2825f10701', '127.0.0.1', 1474489267, '__ci_last_regenerate|i:1474489267;'),
('fd77d56d95658e5f7b3afc4cda610e50d56eaebc', '127.0.0.1', 1474550101, '__ci_last_regenerate|i:1474550101;'),
('fd78f8c1a762044a6c0e528e3b24b61a74fbfcc4', '127.0.0.1', 1473886806, '__ci_last_regenerate|i:1473886806;'),
('fdb1fd3cd74072aa8964b3a4b9d258c71d169f4c', '127.0.0.1', 1472560031, '__ci_last_regenerate|i:1472559748;'),
('febb9895b28c943f0dd6d9ff9d2c7fca1e15e02e', '127.0.0.1', 1473775368, '__ci_last_regenerate|i:1473775368;'),
('ff0006d0b0c536801dbeda8a795ea9451597d738', '127.0.0.1', 1474489064, '__ci_last_regenerate|i:1474489064;'),
('ff346011b592dbae054142ab9b4e0f4efc8bb30b', '127.0.0.1', 1473947955, '__ci_last_regenerate|i:1473947955;'),
('ff46792baba31e83467e3f4cc98dd88f45faaa62', '127.0.0.1', 1473886581, '__ci_last_regenerate|i:1473886581;'),
('ff495c386daa7beddc6188d1e288336564b0da6f', '127.0.0.1', 1474493111, '__ci_last_regenerate|i:1474493111;'),
('fffcd397fcb3ef48bdc139d563c55badd65d307a', '127.0.0.1', 1473853925, '__ci_last_regenerate|i:1473853925;');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `picture` varchar(150) NOT NULL DEFAULT 'user_default.png',
  `facebook_id` bigint(20) DEFAULT NULL,
  `status` enum('enable','disable') DEFAULT 'enable',
  `user_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user`
--

INSERT INTO `user` (`user_id`, `create_time`, `username`, `email`, `password`, `name`, `picture`, `facebook_id`, `status`, `user_type_id`) VALUES
(2, '2016-09-08 23:40:18', 'denis', 'denis@wvtodoz.com.br', '', 'Denis Akao', 'user_default.png', NULL, 'enable', 2),
(8, '2016-09-09 13:27:54', 'denis1', 'de.akao@gmail.com', 'MMcq8q1xZ8Ko0LO937IqinlujCOx5Y0E2rxbzvWVxMu1aw0+npz7OaPGjCNNDLgzhoriCq0hxHNGBrGirHiszQ==', 'Denis', 'user_default.png', 10154338761658463, 'enable', 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_info`
--

CREATE TABLE `user_info` (
  `user_info_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `info_key` varchar(45) DEFAULT NULL,
  `info_value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user_info`
--

INSERT INTO `user_info` (`user_info_id`, `user_id`, `info_key`, `info_value`) VALUES
(1, 8, 'requestChef', 'true'),
(2, 8, 'category_id', '1'),
(3, 8, 'bairro', 'Brooklin'),
(4, 8, 'cep', '04566000'),
(5, 8, 'complemento', '321'),
(6, 8, 'curriculo', 'test'),
(7, 8, 'endereco', 'Rua Michigan'),
(8, 8, 'numero', '531'),
(9, 8, 'telefone', '(11) 12312-3123'),
(10, 8, 'picture', 'user_default.png');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_types`
--

CREATE TABLE `user_types` (
  `user_type_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `label` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user_types`
--

INSERT INTO `user_types` (`user_type_id`, `name`, `label`) VALUES
(1, 'admin', 'Administrador'),
(2, 'chef', 'Chef'),
(3, 'convidado', 'Convidado'),
(4, 'acompanhante', 'Acompanhante');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `fk_events_user1_idx` (`user_id`),
  ADD KEY `fk_events_event_types1_idx` (`event_type_id`),
  ADD KEY `index4` (`start`),
  ADD KEY `index5` (`end`),
  ADD KEY `index6` (`invite_limit`),
  ADD KEY `index7` (`create_time`);

--
-- Indexes for table `event_comments`
--
ALTER TABLE `event_comments`
  ADD PRIMARY KEY (`event_comment_id`) USING BTREE,
  ADD KEY `fk_event_comments_events1_idx` (`event_id`),
  ADD KEY `index4` (`status`),
  ADD KEY `index5` (`datetime`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `event_gallery`
--
ALTER TABLE `event_gallery`
  ADD PRIMARY KEY (`event_gallery_id`),
  ADD KEY `fk_event_gallery_events1_idx` (`event_id`);

--
-- Indexes for table `event_guests`
--
ALTER TABLE `event_guests`
  ADD PRIMARY KEY (`event_guest_id`),
  ADD KEY `fk_event_guests_events1_idx` (`event_id`),
  ADD KEY `fk_event_guests_user1_idx` (`user_id`);

--
-- Indexes for table `event_infos`
--
ALTER TABLE `event_infos`
  ADD PRIMARY KEY (`event_info_id`) USING BTREE,
  ADD KEY `fk_event_items_events1_idx` (`event_id`),
  ADD KEY `fk_event_items_event_info_types1_idx` (`event_info_type_id`);

--
-- Indexes for table `event_info_types`
--
ALTER TABLE `event_info_types`
  ADD PRIMARY KEY (`event_info_type_id`),
  ADD KEY `index2` (`field_type`);

--
-- Indexes for table `event_types`
--
ALTER TABLE `event_types`
  ADD PRIMARY KEY (`event_type_id`);

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_friends_user1_idx` (`user_id`),
  ADD KEY `fk_friends_user2_idx` (`friend_id`);

--
-- Indexes for table `invite_codes`
--
ALTER TABLE `invite_codes`
  ADD PRIMARY KEY (`invite_id`),
  ADD KEY `fk_codigos_events1_idx` (`event_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `index2` (`email`),
  ADD UNIQUE KEY `index3` (`facebook_id`),
  ADD KEY `index4` (`status`),
  ADD KEY `index5` (`user_type_id`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`user_info_id`),
  ADD KEY `fk_user_informations_user1_idx` (`user_id`),
  ADD KEY `index3` (`info_key`,`info_value`);

--
-- Indexes for table `user_types`
--
ALTER TABLE `user_types`
  ADD PRIMARY KEY (`user_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `event_gallery`
--
ALTER TABLE `event_gallery`
  MODIFY `event_gallery_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `event_guests`
--
ALTER TABLE `event_guests`
  MODIFY `event_guest_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `event_infos`
--
ALTER TABLE `event_infos`
  MODIFY `event_info_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `event_types`
--
ALTER TABLE `event_types`
  MODIFY `event_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `friends`
--
ALTER TABLE `friends`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `invite_codes`
--
ALTER TABLE `invite_codes`
  MODIFY `invite_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `user_info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `user_types`
--
ALTER TABLE `user_types`
  MODIFY `user_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_event_types1` FOREIGN KEY (`event_type_id`) REFERENCES `event_types` (`event_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_events_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `event_comments`
--
ALTER TABLE `event_comments`
  ADD CONSTRAINT `event_comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_event_comments_events1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `event_gallery`
--
ALTER TABLE `event_gallery`
  ADD CONSTRAINT `fk_event_gallery_events1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `event_guests`
--
ALTER TABLE `event_guests`
  ADD CONSTRAINT `fk_event_guests_events1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_event_guests_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `event_infos`
--
ALTER TABLE `event_infos`
  ADD CONSTRAINT `event_infos_ibfk_1` FOREIGN KEY (`event_info_type_id`) REFERENCES `event_types` (`event_type_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_event_items_events1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `friends`
--
ALTER TABLE `friends`
  ADD CONSTRAINT `fk_friends_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_friends_user2` FOREIGN KEY (`friend_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `invite_codes`
--
ALTER TABLE `invite_codes`
  ADD CONSTRAINT `fk_codigos_events1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_user_type` FOREIGN KEY (`user_type_id`) REFERENCES `user_types` (`user_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `user_info`
--
ALTER TABLE `user_info`
  ADD CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
