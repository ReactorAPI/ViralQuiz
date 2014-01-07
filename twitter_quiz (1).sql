-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-01-2014 a las 21:53:00
-- Versión del servidor: 5.5.34
-- Versión de PHP: 5.4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `twitter_quiz`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personalities`
--

CREATE TABLE IF NOT EXISTS `personalities` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `picture` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `personalities`
--

INSERT INTO `personalities` (`id`, `name`, `description`, `picture`) VALUES
(1, 'El Loco', 'Soy Loco', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `twitter_userid` int(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `profile_picture` varchar(80) DEFAULT NULL,
  `processed` tinyint(1) NOT NULL DEFAULT '0',
  `reactor_data` int(11) NOT NULL,
  `twitter_oauth` varchar(50) NOT NULL,
  `twitter_oauth_secret` varchar(50) NOT NULL,
  `json_data` text NOT NULL,
  `personality_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_personality_id` (`personality_id`),
  KEY `personality_id` (`personality_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `twitter_userid`, `username`, `name`, `email`, `profile_picture`, `processed`, `reactor_data`, `twitter_oauth`, `twitter_oauth_secret`, `json_data`, `personality_id`) VALUES
(6, 69478855, 'Daxjma', 'Oahl', 'mail@email.com', 'http://pbs.twimg.com/profile_images/413098555797028864/Dq5ndBDs.png', 0, 0, '69478855-XriZOI5hvJ6s9baGHaeHxs7EoPG6mkGysXaLVtXyk', 'Do3RFKdute7OXKnjpJJOvP3jQSfMVevzhDzUU1K0KVhCk', '{"id":69478855,"id_str":"69478855","name":"Oahl","screen_name":"Daxjma","location":"","description":"720 n0sc0p1n6 skrubz s1nc3 4\\/20 g3t r3kt","url":"http:\\/\\/t.co\\/2af800Nbfi","entities":{"url":{"urls":[{"url":"http:\\/\\/t.co\\/2af800Nbfi","expanded_url":"http:\\/\\/www.doge.kek.tk","display_url":"doge.kek.tk","indices":[0,22]}]},"description":{"urls":[]}},"protected":false,"followers_count":287,"friends_count":291,"listed_count":11,"created_at":"Fri Aug 28 02:20:36 +0000 2009","favourites_count":782,"utc_offset":-10800,"time_zone":"Santiago","geo_enabled":false,"verified":false,"statuses_count":31095,"lang":"en","status":{"created_at":"Mon Jan 06 18:41:20 +0000 2014","id":4.2026383376921e+17,"id_str":"420263833769213952","text":"@aeroplan0 ok n_n","source":"web","truncated":false,"in_reply_to_status_id":4.2026353245461e+17,"in_reply_to_status_id_str":"420263532454612993","in_reply_to_user_id":1532095861,"in_reply_to_user_id_str":"1532095861","in_reply_to_screen_name":"aeroplan0","geo":null,"coordinates":null,"place":null,"contributors":null,"retweet_count":0,"favorite_count":0,"entities":{"hashtags":[],"symbols":[],"urls":[],"user_mentions":[{"screen_name":"aeroplan0","name":"Herminia ","id":1532095861,"id_str":"1532095861","indices":[0,10]}]},"favorited":false,"retweeted":false,"lang":"id"},"contributors_enabled":false,"is_translator":false,"profile_background_color":"3D3430","profile_background_image_url":"http:\\/\\/a0.twimg.com\\/profile_background_images\\/379122277\\/Geometry-Wasteland1.jpg","profile_background_image_url_https":"https:\\/\\/si0.twimg.com\\/profile_background_images\\/379122277\\/Geometry-Wasteland1.jpg","profile_background_tile":true,"profile_image_url":"http:\\/\\/pbs.twimg.com\\/profile_images\\/413098555797028864\\/Dq5ndBDs_normal.png","profile_image_url_https":"https:\\/\\/pbs.twimg.com\\/profile_images\\/413098555797028864\\/Dq5ndBDs_normal.png","profile_banner_url":"https:\\/\\/pbs.twimg.com\\/profile_banners\\/69478855\\/1381299664","profile_link_color":"0900FF","profile_sidebar_border_color":"FF0000","profile_sidebar_fill_color":"000000","profile_text_color":"08FF42","profile_use_background_image":true,"default_profile":false,"default_profile_image":false,"following":false,"follow_request_sent":false,"notifications":false}', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`personality_id`) REFERENCES `personalities` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
