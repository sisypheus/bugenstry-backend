import { Response, Request, NextFunction } from 'express';
import { supabase } from '../../db/supabase';

export async function findAll(req: Request, res: Response<any>, next: NextFunction) {
  try {
    res.json({user1: "tets"});
  } catch (error) {
    next(error);
  }
}

export async function create(req: Request, res: Response<any>, next: NextFunction) {
  try {
    const {email, password} = req.body;
    console.log(email, password);
    console.log(req)

    const {data, error} = await supabase.auth.signUp({
      email,
      password,
    });

    console.log(data, error);

  } catch (error) {
    next(error);
  }
}

export async function createGoogle(req: Request, res: Response<any>, next: NextFunction) {
  try {
    const {email} = req.body;

  } catch (error) {
    next(error);
  }
}