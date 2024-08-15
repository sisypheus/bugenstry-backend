import express from 'express';

import MessageResponse from '../interfaces/MessageResponse';
import users from './users/users.routes';
import bugs from './bugs/bugs.routes';
import organizations from './organizations/organizations.routes';

const router = express.Router();

router.get<{}, MessageResponse>('/', (req, res) => {
  res.json({
    message: 'API - 👋🌎🌍🌏',
  });
});

router.use('/users', users);
router.use('/bugs', bugs);
router.use('/organizations', organizations);

export default router;
