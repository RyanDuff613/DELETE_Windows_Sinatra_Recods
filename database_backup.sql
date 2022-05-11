--
-- PostgreSQL database dump
--

-- Dumped from database version 12.10
-- Dumped by pg_dump version 12.10

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
-- Name: albums; Type: TABLE; Schema: public; Owner: Redwood Room
--

CREATE TABLE public.albums (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.albums OWNER TO "Redwood Room";

--
-- Name: albums_artists; Type: TABLE; Schema: public; Owner: Redwood Room
--

CREATE TABLE public.albums_artists (
    id integer NOT NULL,
    artist_id integer,
    album_id integer
);


ALTER TABLE public.albums_artists OWNER TO "Redwood Room";

--
-- Name: albums_artists_id_seq; Type: SEQUENCE; Schema: public; Owner: Redwood Room
--

CREATE SEQUENCE public.albums_artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_artists_id_seq OWNER TO "Redwood Room";

--
-- Name: albums_artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Redwood Room
--

ALTER SEQUENCE public.albums_artists_id_seq OWNED BY public.albums_artists.id;


--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: Redwood Room
--

CREATE SEQUENCE public.albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_id_seq OWNER TO "Redwood Room";

--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Redwood Room
--

ALTER SEQUENCE public.albums_id_seq OWNED BY public.albums.id;


--
-- Name: artists; Type: TABLE; Schema: public; Owner: Redwood Room
--

CREATE TABLE public.artists (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.artists OWNER TO "Redwood Room";

--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: public; Owner: Redwood Room
--

CREATE SEQUENCE public.artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artists_id_seq OWNER TO "Redwood Room";

--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Redwood Room
--

ALTER SEQUENCE public.artists_id_seq OWNED BY public.artists.id;


--
-- Name: songs; Type: TABLE; Schema: public; Owner: Redwood Room
--

CREATE TABLE public.songs (
    id integer NOT NULL,
    name character varying,
    album_id integer
);


ALTER TABLE public.songs OWNER TO "Redwood Room";

--
-- Name: songs_id_seq; Type: SEQUENCE; Schema: public; Owner: Redwood Room
--

CREATE SEQUENCE public.songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.songs_id_seq OWNER TO "Redwood Room";

--
-- Name: songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Redwood Room
--

ALTER SEQUENCE public.songs_id_seq OWNED BY public.songs.id;


--
-- Name: albums id; Type: DEFAULT; Schema: public; Owner: Redwood Room
--

ALTER TABLE ONLY public.albums ALTER COLUMN id SET DEFAULT nextval('public.albums_id_seq'::regclass);


--
-- Name: albums_artists id; Type: DEFAULT; Schema: public; Owner: Redwood Room
--

ALTER TABLE ONLY public.albums_artists ALTER COLUMN id SET DEFAULT nextval('public.albums_artists_id_seq'::regclass);


--
-- Name: artists id; Type: DEFAULT; Schema: public; Owner: Redwood Room
--

ALTER TABLE ONLY public.artists ALTER COLUMN id SET DEFAULT nextval('public.artists_id_seq'::regclass);


--
-- Name: songs id; Type: DEFAULT; Schema: public; Owner: Redwood Room
--

ALTER TABLE ONLY public.songs ALTER COLUMN id SET DEFAULT nextval('public.songs_id_seq'::regclass);


--
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: Redwood Room
--

COPY public.albums (id, name) FROM stdin;
22	Whats the Story Morning Glory?
23	Definitely Maybe
\.


--
-- Data for Name: albums_artists; Type: TABLE DATA; Schema: public; Owner: Redwood Room
--

COPY public.albums_artists (id, artist_id, album_id) FROM stdin;
1	5	8
2	5	12
3	6	15
4	6	15
5	6	15
6	6	15
7	6	15
8	6	15
9	7	17
10	7	17
11	7	16
12	7	16
15	8	22
16	8	22
\.


--
-- Data for Name: artists; Type: TABLE DATA; Schema: public; Owner: Redwood Room
--

COPY public.artists (id, name) FROM stdin;
8	Oasis
10	The Beatles
11	Bob Dylan
\.


--
-- Data for Name: songs; Type: TABLE DATA; Schema: public; Owner: Redwood Room
--

COPY public.songs (id, name, album_id) FROM stdin;
8	Wonderwall	22
9	Champagne Supernova	22
10	Supersonic	23
11	Cigarettes and Alcohol	23
12	Live Forever	23
\.


--
-- Name: albums_artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Redwood Room
--

SELECT pg_catalog.setval('public.albums_artists_id_seq', 16, true);


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Redwood Room
--

SELECT pg_catalog.setval('public.albums_id_seq', 23, true);


--
-- Name: artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Redwood Room
--

SELECT pg_catalog.setval('public.artists_id_seq', 11, true);


--
-- Name: songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Redwood Room
--

SELECT pg_catalog.setval('public.songs_id_seq', 12, true);


--
-- Name: albums_artists albums_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: Redwood Room
--

ALTER TABLE ONLY public.albums_artists
    ADD CONSTRAINT albums_artists_pkey PRIMARY KEY (id);


--
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: public; Owner: Redwood Room
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);


--
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: public; Owner: Redwood Room
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: songs songs_pkey; Type: CONSTRAINT; Schema: public; Owner: Redwood Room
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

