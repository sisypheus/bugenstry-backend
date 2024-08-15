import express from 'express';
import helmet from 'helmet';
import cors from 'cors';

require('dotenv').config();

import * as middlewares from './middlewares';
import api from './api';

const app = express();

app.use(express.urlencoded({ extended: true }));
app.use(helmet());
app.use(cors());
app.use(express.json());

app.get<{}, String>('/', (req, res) => {
  res.json("API - 👋🌎🌍🌏");
});

app.use('/api/v1', api);

app.use(middlewares.notFound);
app.use(middlewares.errorHandler);

export default app;
