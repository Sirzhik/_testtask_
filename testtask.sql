--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-06-27 00:19:51 EEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3638 (class 1262 OID 16413)
-- Name: testtask; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE testtask WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE testtask OWNER TO postgres;

\connect testtask

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16414)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    manager integer,
    subuser integer
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16417)
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.groups_id_seq OWNER TO postgres;

--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 216
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- TOC entry 222 (class 1259 OID 16468)
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requests (
    id integer NOT NULL,
    request json,
    response json,
    sender integer
);


ALTER TABLE public.requests OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16467)
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.requests_id_seq OWNER TO postgres;

--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 221
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requests_id_seq OWNED BY public.requests.id;


--
-- TOC entry 217 (class 1259 OID 16424)
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role (
    id integer NOT NULL,
    role character varying(50)
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16427)
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_id_seq OWNER TO postgres;

--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;


--
-- TOC entry 219 (class 1259 OID 16428)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text,
    password character varying(32),
    token character varying(32),
    roleid integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16433)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3458 (class 2604 OID 16434)
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- TOC entry 3461 (class 2604 OID 16471)
-- Name: requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests ALTER COLUMN id SET DEFAULT nextval('public.requests_id_seq'::regclass);


--
-- TOC entry 3459 (class 2604 OID 16436)
-- Name: user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


--
-- TOC entry 3460 (class 2604 OID 16437)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3625 (class 0 OID 16414)
-- Dependencies: 215
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.groups VALUES (1, 4, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.groups VALUES (2, 4, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.groups VALUES (6, 4, 14) ON CONFLICT DO NOTHING;
INSERT INTO public.groups VALUES (7, 18, 20) ON CONFLICT DO NOTHING;


--
-- TOC entry 3632 (class 0 OID 16468)
-- Dependencies: 222
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.requests VALUES (1, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "text"}', '{"response": "Sended"}', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (2, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "\u0422\u0435\u0441\u0442 \u043a\u0438\u0440\u0438\u043b\u0438\u0446\u0456"}', '{"response": "Sended"}', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (3, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "Друга спроба"}', '{"response": "Sended"}', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (4, '{"bottoken": "7050916373:AAF6fBgRkw22Ttklg8p_T36JiVXOiuZX45I", "chatid": 6414962502, "message": "тест"}', '{"send_error": "Telegram server says - Bad Request: chat not found"}', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (5, '{"bottoken": "7050916373:AAF6fBgRkw22Ttklg8p_T36JiVXOiuZX45I", "chatid": 948212683, "message": "тест"}', '{"response": "Sended"}', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (6, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "тест"}', '{"response": "Sended"}', 14) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (7, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "тест"}', '{"send_error": "send() got an unexpected keyword argument ''chat_id''"}', 14) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (8, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "тест"}', '{"send_error": "send() got an unexpected keyword argument ''chat_id''"}', 14) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (9, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "тест"}', '{"response": "Sended"}', 14) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (10, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "тест"}', '{"response": "Sended"}', 14) ON CONFLICT DO NOTHING;
INSERT INTO public.requests VALUES (11, '{"bottoken": "7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI", "chatid": 948212683, "message": "тест"}', '{"response": "Sended"}', 14) ON CONFLICT DO NOTHING;


--
-- TOC entry 3627 (class 0 OID 16424)
-- Dependencies: 217
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_role VALUES (1, 'user') ON CONFLICT DO NOTHING;
INSERT INTO public.user_role VALUES (2, 'manager') ON CONFLICT DO NOTHING;
INSERT INTO public.user_role VALUES (3, 'admin') ON CONFLICT DO NOTHING;


--
-- TOC entry 3629 (class 0 OID 16428)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'user1', 'f190ce9ac8445d249747cab7be43f7d5', '2584eacc66905904f791554145e203c9', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (3, 'user2', 'f190ce9ac8445d249747cab7be43f7d4', '2584eacc66905904f791554145e203c0', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (4, 'manager1', 'A190ce9ac8445d249747cab7be43f7d4', '3484eacc66905904f791554145e203c0', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (9, 'user3', '4fc88bd8e0cc3a6048530e9e4e887442', 'bb153c74230b4eb4852158938bcdc18e', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (14, 'user4', '4fc88bd8e0cc3a6048530e9e4e887442', '40a6a5e0cd139aad4474462a2cdc1033', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (15, 'admin', 'a02005bfad55ba8f265a532e874142d0', 'ca9f259c4ee8f0d81aef1578fe855752', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (18, 'manager2', '5cda7d20100f0d44e1c33ef4192dde23', '1728a6e053a9053c0714d846864f3d37', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (20, 'user0', '827ccb0eea8a706c4c34a16891f84e7b', 'c8d5cc9f394bfb6e0d08ccaf6236d1b9', 1) ON CONFLICT DO NOTHING;


--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 216
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 7, true);


--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 221
-- Name: requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.requests_id_seq', 11, true);


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_id_seq', 3, true);


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 21, true);


--
-- TOC entry 3463 (class 2606 OID 16439)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3475 (class 2606 OID 16475)
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- TOC entry 3465 (class 2606 OID 16443)
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 3467 (class 2606 OID 16445)
-- Name: user_role user_role_role_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_key UNIQUE (role);


--
-- TOC entry 3469 (class 2606 OID 16447)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3471 (class 2606 OID 16449)
-- Name: users users_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_token_key UNIQUE (token);


--
-- TOC entry 3473 (class 2606 OID 16451)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3476 (class 2606 OID 16486)
-- Name: groups fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_user FOREIGN KEY (subuser) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3480 (class 2606 OID 16491)
-- Name: requests fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT fk_user FOREIGN KEY (sender) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3477 (class 2606 OID 16452)
-- Name: groups groups_manager_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_manager_fkey FOREIGN KEY (manager) REFERENCES public.users(id);


--
-- TOC entry 3478 (class 2606 OID 16457)
-- Name: groups groups_subuser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_subuser_fkey FOREIGN KEY (subuser) REFERENCES public.users(id);


--
-- TOC entry 3481 (class 2606 OID 16476)
-- Name: requests requests_sender_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_sender_fkey FOREIGN KEY (sender) REFERENCES public.users(id);


--
-- TOC entry 3479 (class 2606 OID 16462)
-- Name: users role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT role_id FOREIGN KEY (roleid) REFERENCES public.user_role(id);


-- Completed on 2024-06-27 00:19:52 EEST

--
-- PostgreSQL database dump complete
--

