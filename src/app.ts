import express from 'express';
import helmet from 'helmet';
import cors from 'cors';

require('dotenv').config();

import * as middlewares from './middlewares';
import api from './api';
import MessageResponse from './interfaces/MessageResponse';
import { prisma } from './db/prisma';

const app = express();

app.use(helmet());
app.use(cors());
app.use(express.json());

app.get<{}, MessageResponse>('/', (req, res) => {
  prisma.bug.findMany().then((bugs: any) => {
    res.json(bugs);
  });
  // res.json({
  //   message: 'hi',
  // });
});

app.use('/api/v1', api);

app.use(middlewares.notFound);
app.use(middlewares.errorHandler);

export default app;
