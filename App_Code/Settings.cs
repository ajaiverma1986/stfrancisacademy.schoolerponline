//***************************************************
//  Creator Name    : Dipak Sinha
//  Creation Date   : 16/10/2007
//  Reason          : To Create Properties of Settings Table Fields.
//  Updated By      :
//  Update Date     :
//***************************************************

/// <summary>
/// Description for Settings
/// </summary>
public class Settings
{
    #region All constructors.

    public Settings()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #endregion All constructors.

    #region All Properties

    private int _SID;

    public int SID
    {
        get { return _SID; }
        set { _SID = value; }
    }

    private string _Caption;

    public string Caption
    {
        get { return _Caption; }
        set { _Caption = value; }
    }

    private string _ClubCondition;

    public string ClubCondition
    {
        get { return _ClubCondition; }
        set { _ClubCondition = value; }
    }

    private string _ClubDescription;

    public string ClubDescription
    {
        get { return _ClubDescription; }
        set { _ClubDescription = value; }
    }

    private double _Limits;

    public double Limits
    {
        get { return _Limits; }
        set { _Limits = value; }
    }

    private byte _Active;

    public byte Active
    {
        get { return _Active; }
        set { _Active = value; }
    }

    #endregion All Properties
}