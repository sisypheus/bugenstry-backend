import { Response, Request, NextFunction } from 'express';

export async function findAll(req: Request, res: Response<any>, next: NextFunction) {
  try {
    res.json({user1: "tets"});
  } catch (error) {
    next(error);
  }
}