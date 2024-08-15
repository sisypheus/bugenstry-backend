import { Response, Request, NextFunction } from 'express';
import { prisma } from '../../db/prisma';

export async function findAll(req: Request, res: Response<any>, next: NextFunction) {
  return res.json({res: prisma.bug.findMany()});
}