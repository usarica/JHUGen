      !-- H -> [l^-(i3) lb(i4)] [l^-(i5) lb(i6)]
      function anomhzzamp(i3,i4,i5,i6,jh,shat,q3_q3,q4_q4,za,zb)
      implicit none
      include 'mxpart.f'
      include 'masses.f'
      include 'spinzerohiggs_anomcoupl.f'
      include 'zprods_decl.f'
      double complex anomhzzamp
      integer i3,i4,i5,i6,jh ! jh is Higgs 1, 2
      double precision shat,q3_q3,q4_q4,LambdaJHBSM
      double complex ghz1_dyn,ghz2_dyn,ghz3_dyn,ghz4_dyn
      double complex FFa1, FFa2, FFa3
      double complex aa1,aa2,aa3

c------ HZZ DECAY CONVENTIONS
      IF( AllowAnomalousCouplings.eq.1 ) THEN

c------ FORM FACTORS FOR ANOMALOUS COUPLINGS
c L1L2
      FFa1 = za(i3,i5)*zb(i4,i6)*shat
      FFa2 = -0.5d0*za(i3,i5)**2*zb(i3,i6)*zb(i4,i5)
     &       -0.5d0*za(i3,i5)*za(i3,i6)*zb(i3,i6)*zb(i4,i6)
     &       -0.5d0*za(i3,i5)*za(i4,i5)*zb(i4,i5)*zb(i4,i6)
     &       -0.5d0*za(i3,i6)*za(i4,i5)*zb(i4,i6)**2
      FFa3 =  0.5d0*za(i3,i4)*za(i5,i6)*zb(i4,i6)**2
     &       -0.5d0*za(i3,i5)**2*zb(i3,i4)*zb(i5,i6)

      FFa3 = FFa3 * (0d0,-1d0)!  phase convention to match JHUGen

c--- q^2 dependent couplings
      call HVVSpinZeroDynCoupl(ghz1_dyn,1,jh,q3_q3,q4_q4,shat,.false.)
      call HVVSpinZeroDynCoupl(ghz2_dyn,2,jh,q3_q3,q4_q4,shat,.false.)
      call HVVSpinZeroDynCoupl(ghz3_dyn,3,jh,q3_q3,q4_q4,shat,.false.)
      call HVVSpinZeroDynCoupl(ghz4_dyn,4,jh,q3_q3,q4_q4,shat,.false.)

      if(jh.eq.1) then
      LambdaJHBSM=LambdaBSM
      else
      LambdaJHBSM=Lambda2BSM
      endif

      aa1 =ghz1_dyn*zmass**2/shat
     &     + (shat-q3_q3-q4_q4)/shat*
     &       (ghz2_dyn
     &       +ghz3_dyn*(shat-q3_q3-q4_q4)/4d0/LambdaJHBSM**2)
      aa2 =-2d0*ghz2_dyn
     &     -ghz3_dyn*(shat-q3_q3-q4_q4)/2d0/LambdaJHBSM**2
      aa3 =-2d0*ghz4_dyn


      aa1 = aa1 / zmass**2 !-- F
      aa2 = aa2 / zmass**2 !-- F
      aa3 = aa3 / zmass**2 !-- F

      anomhzzamp = ( aa1*FFa1 + aa2*FFa2 + aa3*FFa3 )

      ELSE

      anomhzzamp = za(i3,i5)*zb(i4,i6)

      ENDIF

      return

      end


      !-- H -> [l^-(i3) lb(i4)] [(gamma* ->) l^-(i5) lb(i6)]
      function anomhzaamp(i3,i4,i5,i6,jh,shat,q3_q3,q4_q4,za,zb)
      implicit none
      include 'constants.f'
      include 'masses.f'
      include 'spinzerohiggs_anomcoupl.f'
      include 'zprods_decl.f'
      double complex anomhzaamp
      integer i3,i4,i5,i6,jh ! jh is Higgs 1, 2
      double precision shat,q3_q3,q4_q4,LambdaJHBSM
      double complex ghz1_dyn,ghz2_dyn,ghz3_dyn,ghz4_dyn
      double complex FFa1, FFa2, FFa3
      double complex aa1,aa2,aa3
      logical checkHZAcouplings

      anomhzaamp = czip ! No ZA->4f amplitude at LO SM

c------ HZZ DECAY CONVENTIONS
      IF(AllowAnomalousCouplings.eq.1) THEN
      if(checkHZAcouplings(jh)) then

c------ FORM FACTORS FOR ANOMALOUS COUPLINGS
c L1L2
      FFa1 = za(i3,i5)*zb(i4,i6)*shat
      FFa2 = -0.5d0*za(i3,i5)**2*zb(i3,i6)*zb(i4,i5)
     &       -0.5d0*za(i3,i5)*za(i3,i6)*zb(i3,i6)*zb(i4,i6)
     &       -0.5d0*za(i3,i5)*za(i4,i5)*zb(i4,i5)*zb(i4,i6)
     &       -0.5d0*za(i3,i6)*za(i4,i5)*zb(i4,i6)**2
      FFa3 =  0.5d0*za(i3,i4)*za(i5,i6)*zb(i4,i6)**2
     &       -0.5d0*za(i3,i5)**2*zb(i3,i4)*zb(i5,i6)

      FFa3 = FFa3 * (0d0,-1d0)!  phase convention to match JHUGen

c--- q^2 dependent couplings
      ! q4_q4==q**2 of gamma*
      call HVVSpinZeroDynCoupl(ghz1_dyn,5,jh,0d0,q4_q4,shat,.false.)
      call HVVSpinZeroDynCoupl(ghz2_dyn,6,jh,0d0,q4_q4,shat,.false.)
      call HVVSpinZeroDynCoupl(ghz3_dyn,7,jh,0d0,q4_q4,shat,.false.)
      call HVVSpinZeroDynCoupl(ghz4_dyn,8,jh,0d0,q4_q4,shat,.false.)

      if(jh.eq.1) then
      LambdaJHBSM=LambdaBSM
      else
      LambdaJHBSM=Lambda2BSM
      endif

      aa1 =ghz1_dyn*zmass**2/shat
     &     + (shat-q3_q3-q4_q4)/shat*
     &       (ghz2_dyn
     &       +ghz3_dyn*(shat-q3_q3-q4_q4)/4d0/LambdaJHBSM**2)
      aa2 =-2d0*ghz2_dyn
     &     -ghz3_dyn*(shat-q3_q3-q4_q4)/2d0/LambdaJHBSM**2
      aa3 =-2d0*ghz4_dyn


      aa1 = aa1 / zmass**2 !-- F
      aa2 = aa2 / zmass**2 !-- F
      aa3 = aa3 / zmass**2 !-- F

      anomhzaamp = ( aa1*FFa1 + aa2*FFa2 + aa3*FFa3 )
      endif
      ENDIF

      return

      end


      !-- H -> [(gamma* ->) l^-(i3) lb(i4)] [(gamma* ->) l^-(i5) lb(i6)]
      function anomhaaamp(i3,i4,i5,i6,jh,shat,q3_q3,q4_q4,za,zb)
      implicit none
      include 'constants.f'
      include 'masses.f'
      include 'spinzerohiggs_anomcoupl.f'
      include 'zprods_decl.f'
      double complex anomhaaamp
      integer i3,i4,i5,i6,jh ! jh is Higgs 1, 2
      double precision shat,q3_q3,q4_q4,LambdaJHBSM
      double complex ghz2_dyn,ghz3_dyn,ghz4_dyn
      double complex FFa1, FFa2, FFa3
      double complex aa1,aa2,aa3
      logical checkHAAcouplings

      anomhaaamp = czip ! No AA->4f amplitude at LO SM

c------ HZZ DECAY CONVENTIONS
      IF(AllowAnomalousCouplings.eq.1) THEN
      if(checkHAAcouplings(jh)) then

c------ FORM FACTORS FOR ANOMALOUS COUPLINGS
c L1L2
      FFa1 = za(i3,i5)*zb(i4,i6)*shat
      FFa2 = -0.5d0*za(i3,i5)**2*zb(i3,i6)*zb(i4,i5)
     &       -0.5d0*za(i3,i5)*za(i3,i6)*zb(i3,i6)*zb(i4,i6)
     &       -0.5d0*za(i3,i5)*za(i4,i5)*zb(i4,i5)*zb(i4,i6)
     &       -0.5d0*za(i3,i6)*za(i4,i5)*zb(i4,i6)**2
      FFa3 =  0.5d0*za(i3,i4)*za(i5,i6)*zb(i4,i6)**2
     &       -0.5d0*za(i3,i5)**2*zb(i3,i4)*zb(i5,i6)

      FFa3 = FFa3 * (0d0,-1d0)!  phase convention to match JHUGen

c--- q^2 dependence in couplings does not exist in gsgs
      call HVVSpinZeroDynCoupl(ghz2_dyn,9,jh,q3_q3,q4_q4,shat,.false.)
      call HVVSpinZeroDynCoupl(ghz3_dyn,10,jh,q3_q3,q4_q4,shat,.false.)
      call HVVSpinZeroDynCoupl(ghz4_dyn,11,jh,q3_q3,q4_q4,shat,.false.)

      if(jh.eq.1) then
      LambdaJHBSM=LambdaBSM
      else
      LambdaJHBSM=Lambda2BSM
      endif

      aa1 = !ghz1_dyn*zmass**2/shat ! No ghz1
     &     + (shat-q3_q3-q4_q4)/shat*
     &       (ghz2_dyn
     &       +ghz3_dyn*(shat-q3_q3-q4_q4)/4d0/LambdaJHBSM**2)
      aa2 =-2d0*ghz2_dyn
     &     -ghz3_dyn*(shat-q3_q3-q4_q4)/2d0/LambdaJHBSM**2
      aa3 =-2d0*ghz4_dyn


      ! Divide by zmass**2 just like in ZZ or ZA
      ! although it has no meaning here
      aa1 = aa1 / zmass**2 !-- F
      aa2 = aa2 / zmass**2 !-- F
      aa3 = aa3 / zmass**2 !-- F

      anomhaaamp = ( aa1*FFa1 + aa2*FFa2 + aa3*FFa3 )

      endif
      ENDIF

      return

      end


      !-- H -> [nu(i3) l^+(i4)] [l^-(i5) nub(i6)]
      function anomhwwamp(i3,i4,i5,i6,jh,shat,q3_q3,q4_q4,za,zb)
      implicit none
      include 'constants.f'
      include 'masses.f'
      include 'spinzerohiggs_anomcoupl.f'
      include 'zprods_decl.f'
      double complex anomhwwamp
      integer i3,i4,i5,i6,jh ! jh is Higgs 1, 2
      double precision shat,q3_q3,q4_q4,LambdaJHBSM
      double complex ghw1_dyn,ghw2_dyn,ghw3_dyn,ghw4_dyn
      double complex FFa1, FFa2, FFa3
      double complex aa1,aa2,aa3

c------ HZZ=-HWW DECAY CONVENTIONS
      IF( AllowAnomalousCouplings.eq.1 ) THEN

c------ FORM FACTORS FOR ANOMALOUS COUPLINGS
c L1L2
      FFa1 = za(i3,i5)*zb(i4,i6)*shat
      FFa2 = -0.5d0*za(i3,i5)**2*zb(i3,i6)*zb(i4,i5)
     &       -0.5d0*za(i3,i5)*za(i3,i6)*zb(i3,i6)*zb(i4,i6)
     &       -0.5d0*za(i3,i5)*za(i4,i5)*zb(i4,i5)*zb(i4,i6)
     &       -0.5d0*za(i3,i6)*za(i4,i5)*zb(i4,i6)**2
      FFa3 =  0.5d0*za(i3,i4)*za(i5,i6)*zb(i4,i6)**2
     &       -0.5d0*za(i3,i5)**2*zb(i3,i4)*zb(i5,i6)

      FFa3 = FFa3 * (0d0,-1d0)!  phase convention to match JHUGen

c--- q^2-dependent couplings
      call HVVSpinZeroDynCoupl(ghw1_dyn,1,jh,q3_q3,q4_q4,shat,.true.)
      call HVVSpinZeroDynCoupl(ghw2_dyn,2,jh,q3_q3,q4_q4,shat,.true.)
      call HVVSpinZeroDynCoupl(ghw3_dyn,3,jh,q3_q3,q4_q4,shat,.true.)
      call HVVSpinZeroDynCoupl(ghw4_dyn,4,jh,q3_q3,q4_q4,shat,.true.)

      if(jh.eq.1) then
      LambdaJHBSM=LambdaBSM
      else
      LambdaJHBSM=Lambda2BSM
      endif

      aa1 =ghw1_dyn*wmass**2/shat
     &     + (shat-q3_q3-q4_q4)/shat*
     &       (ghw2_dyn
     &       +ghw3_dyn*(shat-q3_q3-q4_q4)/4d0/LambdaJHBSM**2)
      aa2 =-2d0*ghw2_dyn
     &     -ghw3_dyn*(shat-q3_q3-q4_q4)/2d0/LambdaJHBSM**2
      aa3 =-2d0*ghw4_dyn

      aa1 = aa1 / wmass**2
      aa2 = aa2 / wmass**2
      aa3 = aa3 / wmass**2

      anomhwwamp = ( aa1*FFa1 + aa2*FFa2 + aa3*FFa3 )
      !print *,"anomhwwamp(",i3,i4,i5,i6,")=",anomhwwamp

      ELSE

      anomhwwamp = za(i3,i5)*zb(i4,i6)

      ENDIF

      return

      end


      !-- g(i1) g(i2) =|>- + >- H
      subroutine anomhggvtxamp(i1,i2,jh,za,zb,hggvtxamp)
      implicit none
      include 'constants.f'
      include 'masses.f'
      include 'scale.f'
      include 'spinzerohiggs_anomcoupl.f'
      include 'sprods_com.f'
      include 'zprods_decl.f'
      integer i1,i2,jh ! jh is Higgs 1, 2
      integer iq,igen,iv
      double precision mfsq(2,2) ! (qgen,b/t)
      double precision tauinv(2,2) ! (qgen,b/t)
      double complex a1(2),a3(2) ! (qgen)
      double complex kappaj(2,2) ! (qgen,b/t)
      double complex kappaj_tilde(2,2) ! (qgen,b/t)
      double complex qlI3,C0mXq
      double complex hggvtxamp(2,2,2),hggpointvtx(2,2)

      mfsq(1,1)=mb**2
      mfsq(1,2)=mt**2
      mfsq(2,1)=mb_4gen**2
      mfsq(2,2)=mt_4gen**2
      tauinv(:,:)=4d0*mfsq(:,:)/s(i1,i2)

      hggvtxamp(:,:,:)=czip
      hggpointvtx(:,:)=czip
      a1(:)=czip
      a3(:)=czip
      kappaj(:,:)=czip
      kappaj_tilde(:,:)=czip

      IF( AllowAnomalousCouplings.eq.1 ) THEN

      if(jh.eq.1) then

      a1(1) = ghg2+ghg3*s(i1,i2)/4d0/LambdaBSM**2
      a3(1) = -2d0*ghg4
      a1(2)= ghg2_4gen+ghg3_4gen*s(i1,i2)/4d0/LambdaBSM**2
      a3(2)= -2d0*ghg4_4gen

      kappaj(1,1) = kappa_bot
      kappaj_tilde(1,1) = kappa_tilde_bot
      kappaj(1,2) = kappa_top
      kappaj_tilde(1,2) = kappa_tilde_top
      kappaj(2,1) = kappa_4gen_bot
      kappaj_tilde(2,1) = kappa_tilde_4gen_bot
      kappaj(2,2) = kappa_4gen_top
      kappaj_tilde(2,2) = kappa_tilde_4gen_top

      else

      a1(1) = gh2g2+gh2g3*s(i1,i2)/4d0/Lambda2BSM**2
      a3(1) = -2d0*gh2g4
      a1(2)= gh2g2_4gen+gh2g3_4gen*s(i1,i2)/4d0/Lambda2BSM**2
      a3(2)= -2d0*gh2g4_4gen

      kappaj(1,1) = kappa2_bot
      kappaj_tilde(1,1) = kappa2_tilde_bot
      kappaj(1,2) = kappa2_top
      kappaj_tilde(1,2) = kappa2_tilde_top
      kappaj(2,1) = kappa2_4gen_bot
      kappaj_tilde(2,1) = kappa2_tilde_4gen_bot
      kappaj(2,2) = kappa2_4gen_top
      kappaj_tilde(2,2) = kappa2_tilde_4gen_top

      endif

      ELSE

      kappaj(1,1) = cone
      kappaj(1,2) = cone

      ENDIF

      do igen=1,2
      ! Compute the point interaction
      hggpointvtx(1,1) =
     & s(i1,i2)*(
     & a1(igen)
     & - a3(igen)*0.5d0*im*za(i1,i2)*zb(i1,i2)/s(i1,i2)
     & )/3d0
      hggpointvtx(2,2) =
     & s(i1,i2)*(
     & a1(igen)
     & + a3(igen)*0.5d0*im*za(i1,i2)*zb(i1,i2)/s(i1,i2)
     & )/3d0

      do iq=1,2
      iv = mod((iq-1),2)+1

      ! Add one point interaction into the SM-top loop
      if (iq.eq.2) then
      hggvtxamp(iv,:,:) = hggvtxamp(iv,:,:) +
     & hggpointvtx(:,:)
      endif

      C0mXq =
     & qlI3(
     & zip,zip,s(i1,i2),
     & mfsq(igen,iq),mfsq(igen,iq),mfsq(igen,iq),
     & musq,0
     & )

      hggvtxamp(iv,1,1) = hggvtxamp(iv,1,1) +
     & mfsq(igen,iq)*(
     &  kappaj(igen,iq)*(
     &    2d0-C0mXq*s(i1,i2)*(1d0-tauinv(igen,iq))
     &  )
     &  -kappaj_tilde(igen,iq)*(-im)*C0mXq*s(i1,i2)
     & )

      hggvtxamp(iv,2,2) = hggvtxamp(iv,2,2) +
     & mfsq(igen,iq)*(
     &  kappaj(igen,iq)*(
     &    2d0-C0mXq*s(i1,i2)*(1d0-tauinv(igen,iq))
     &  )
     &  +kappaj_tilde(igen,iq)*(-im)*C0mXq*s(i1,i2)
     & )

      enddo
      enddo

      ! Multiply by the tensor structure
      do iv=1,2
      hggvtxamp(iv,1,1)=hggvtxamp(iv,1,1)*za(i1,i2)/zb(i1,i2)
      hggvtxamp(iv,2,2)=hggvtxamp(iv,2,2)*zb(i1,i2)/za(i1,i2)
      enddo

      return
      end

