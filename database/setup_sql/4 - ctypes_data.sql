--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: metpetdb
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	permission	auth	permission
2	group	auth	group
3	user	auth	user
4	content type	contenttypes	contenttype
5	session	sessions	session
6	site	sites	site
7	log entry	admin	logentry
8	api access	tastypie	apiaccess
9	api key	tastypie	apikey
10	group extra	tastyapi	groupextra
11	group access	tastyapi	groupaccess
12	geometry column	tastyapi	geometrycolumn
13	user	tastyapi	user
14	users role	tastyapi	usersrole
15	image type	tastyapi	imagetype
16	georeference	tastyapi	georeference
17	image format	tastyapi	imageformat
18	metamorphic grade	tastyapi	metamorphicgrade
19	metamorphic region	tastyapi	metamorphicregion
20	mineral type	tastyapi	mineraltype
21	mineral	tastyapi	mineral
22	reference	tastyapi	reference
23	region	tastyapi	region
24	rock type	tastyapi	rocktype
25	role	tastyapi	role
26	spatial ref sys	tastyapi	spatialrefsys
27	subsample type	tastyapi	subsampletype
28	admin user	tastyapi	adminuser
29	element	tastyapi	element
30	element mineral type	tastyapi	elementmineraltype
31	image reference	tastyapi	imagereference
32	oxide	tastyapi	oxide
33	oxide mineral type	tastyapi	oxidemineraltype
34	project	tastyapi	project
35	sample	tastyapi	sample
36	sample metamorphic grade	tastyapi	samplemetamorphicgrade
37	sample metamorphic region	tastyapi	samplemetamorphicregion
38	sample mineral	tastyapi	samplemineral
39	sample reference	tastyapi	samplereference
40	sample region	tastyapi	sampleregion
41	sample aliase	tastyapi	samplealiase
42	subsample	tastyapi	subsample
43	grid	tastyapi	grid
44	chemical analyses	tastyapi	chemicalanalyses
45	chemical analysis element	tastyapi	chemicalanalysiselement
46	chemical analysis oxide	tastyapi	chemicalanalysisoxide
47	image	tastyapi	image
48	image comment	tastyapi	imagecomment
49	image on grid	tastyapi	imageongrid
50	project invite	tastyapi	projectinvite
51	project member	tastyapi	projectmember
52	project sample	tastyapi	projectsample
53	sample comment	tastyapi	samplecomment
54	uploaded file	tastyapi	uploadedfile
55	xray image	tastyapi	xrayimage
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metpetdb
--

SELECT pg_catalog.setval('django_content_type_id_seq', 55, true);


--
-- PostgreSQL database dump complete
--

