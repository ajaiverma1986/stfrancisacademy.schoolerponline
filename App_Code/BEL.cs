using System;

/// <summary>
/// Summary description for BEL
/// </summary>
public class BEL
{
    public BEL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Variables

    /// <summary>

    //studentadmissionlist

    public static string _searchbyName { get; set; }

    public static string _searchbyAdmissionNo { get; set; }

    public static string _searchbyClass { get; set; }

    public static string _searchtransport { get; set; }

    public static int _countnoofStudents { get; set; }

    /// </summary>

    public static int _branchid { get; set; }

    public static int _applyclassid { get; set; }

    public static int _modestatic { get; set; }

    public int _studybefore { get; set; }

    public int _brid { get; set; }

    public string _branchname { get; set; }

    public string _bankbranch { get; set; }

    public static string _searchvalue { get; set; }

    public string _student_First_Name { get; set; }

    public string _student_Mid_Name { get; set; }

    public string _student_Last_Name { get; set; }

    public string _admission_Date { get; set; }

    public DateTime _date_of_Birth { get; set; }

    public DateTime _draft_date { get; set; }

    public int _gender { get; set; }

    public double _height { get; set; }

    public double _weight { get; set; }

    public string _applyclass { get; set; }

    public string _section { get; set; }

    public int _sectionid { get; set; }

    public int _classid { get; set; }

    public string _upload_student_image { get; set; }

    public string _student_age { get; set; }

    public int _transportation { get; set; }

    public string _nationality { get; set; }

    public string _houseno { get; set; }

    public string _appartment { get; set; }

    public string _street { get; set; }

    public string _landmark { get; set; }

    public string _pincode { get; set; }

    public string _languages_spoken { get; set; }

    // Father Details
    public string _father_Name { get; set; }

    public int _father_QualificatioID { get; set; }

    public string _father_Occupation { get; set; }

    public string _father_Organisation { get; set; }

    public string _father_PhoneNo_Residential { get; set; }

    public string _father_PhoneNo_Office { get; set; }

    public string _father_MobileNo { get; set; }

    public string _father_Email { get; set; }

    public string _Fqualification_other { get; set; }

    //Mother Details
    public string _mother_Name { get; set; }

    public int _mother_QualificatioID { get; set; }

    public string _mother_Occupation { get; set; }

    public string _mother_Organisation { get; set; }

    public string _mother_PhoneNo_Residential { get; set; }

    public string _mother_PhoneNo_Office { get; set; }

    public string _mother_MobileNo { get; set; }

    public string _mother_Email { get; set; }

    public string _Mqualification_other { get; set; }

    //Siblings details
    public string _SibName1 { get; set; }

    public string _Sibage1 { get; set; }

    public string _Sibschool1 { get; set; }

    public string _SibName2 { get; set; }

    public string _Sibage2 { get; set; }

    public string _Sibschool2 { get; set; }

    public string _SibName3 { get; set; }

    public string _Sibage3 { get; set; }

    public string _Sibschool3 { get; set; }

    //previous Schooling
    public int _previous_schooling { get; set; }

    public string _previous_schooling_details { get; set; }

    //Medical
    public int _bloodid { get; set; }

    public string _Specific_ailments_Suffered { get; set; }

    public string _Surgery_undergone { get; set; }

    public string _allergy { get; set; }

    public int _regular_medication_status { get; set; }

    public string _regular_medication_Detial { get; set; }

    public int _phobias_status { get; set; }

    public string _phobias_Detial { get; set; }

    public string _vaccination_name { get; set; }

    public string _vaccination_id { get; set; }

    //Instruction and emergency contact name and contact no
    public string _Any_specific_Instruction { get; set; }

    public string _EMERGENCY_CONTACT_name1 { get; set; }

    public string _EMERGENCY_mobileno1 { get; set; }

    public string _emergency_address1 { get; set; }

    public string _EMERGENCY_CONTACT_name2 { get; set; }

    public string _EMERGENCY_mobileno2 { get; set; }

    public string _emergency_address2 { get; set; }

    public string _signature_upolad { get; set; }

    public string _name_of_signee { get; set; }

    public string _relation_to_child { get; set; }

    //Fees detials and pay
    public string _feeid { get; set; }

    public string _FeeName { get; set; }

    public string _FeeAmount { get; set; }

    public string _Discount { get; set; }

    public string _ckdisid { get; set; }

    public string _paymodeid { get; set; }

    public string _bankname { get; set; }

    public string _checkno { get; set; }

    public double _payableamt { get; set; }

    public double _paynowamount { get; set; }

    public string _monthids { get; set; }

    public string _mode { get; set; }

    public string _paytypename { get; set; }

    public int _paytypeID { get; set; }

    public string _feepaynow { get; set; }

    public DateTime _signaturedate { get; set; }

    //monthwise fee

    public static int _pagesize { get; set; }

    public static int _currentpage { get; set; }

    public static string _feetype { get; set; }

    public static int _monthid { get; set; }

    public static double _totalfee { get; set; }

    public static double _paidfee { get; set; }

    public static double _balfee { get; set; }

    public static double _recevied { get; set; }

    public static string _sttype { get; set; }

    public static int _adid { get; set; }

    public static int _feeTypeid { get; set; }

    public double _actualfine { get; set; }

    public int _adid2 { get; set; }

    public string _finepayornot { get; set; }

    public double _totalfine { get; set; }

    public int _nextmonthid { get; set; }

    public static double _discount { get; set; }

    public static string _searchbydate { get; set; }

    public static string _searchbydate2 { get; set; }

    #endregion Variables

    /// <summary>
    /// Gets or sets the attribute values.
    /// </summary>
    ///
    public static string searchbydate
    {
        get
        {
            return _searchbydate;
        }
        set
        {
            _searchbydate = value;
        }
    }

    public static string searchbydate2
    {
        get
        {
            return _searchbydate2;
        }
        set
        {
            _searchbydate2 = value;
        }
    }

    public static double discount
    {
        get
        {
            return _discount;
        }
        set
        {
            _discount = value;
        }
    }

    public static string searchbyName
    {
        get
        {
            return _searchbyName;
        }
        set
        {
            _searchbyName = value;
        }
    }

    public static string searchbyAdmissionNo
    {
        get
        {
            return _searchbyAdmissionNo;
        }
        set
        {
            _searchbyAdmissionNo = value;
        }
    }

    public static string searchbyClass
    {
        get
        {
            return _searchbyClass;
        }
        set
        {
            _searchbyClass = value;
        }
    }

    public static string searchtransport
    {
        get
        {
            return _searchtransport;
        }
        set
        {
            _searchtransport = value;
        }
    }

    public static int countnoofStudents
    {
        get
        {
            return _countnoofStudents;
        }
        set
        {
            _countnoofStudents = value;
        }
    }

    public static string searchvalue
    {
        get
        {
            return _searchvalue;
        }
        set
        {
            _searchvalue = value;
        }
    }

    public static int branchid
    {
        get
        {
            return _branchid;
        }
        set
        {
            _branchid = value;
        }
    }

    public static int applyclassid
    {
        get
        {
            return _applyclassid;
        }
        set
        {
            _applyclassid = value;
        }
    }

    public static int modestatic
    {
        get
        {
            return _modestatic;
        }
        set
        {
            _modestatic = value;
        }
    }

    public int studybefore
    {
        get
        {
            return _studybefore;
        }
        set
        {
            _studybefore = value;
        }
    }

    public int brid
    {
        get
        {
            return _brid;
        }
        set
        {
            _brid = value;
        }
    }

    public string branchname
    {
        get
        {
            return _branchname;
        }
        set
        {
            _branchname = value;
        }
    }

    public string student_first_name
    {
        get
        {
            return _student_First_Name;
        }
        set
        {
            _student_First_Name = value;
        }
    }

    public string student_mid_name
    {
        get
        {
            return _student_Mid_Name;
        }
        set
        {
            _student_Mid_Name = value;
        }
    }

    public string student_Last_name
    {
        get
        {
            return _student_Last_Name;
        }
        set
        {
            _student_Last_Name = value;
        }
    }

    public string admission_Date
    {
        get
        {
            return _admission_Date;
        }
        set
        {
            _admission_Date = value;
        }
    }

    public DateTime date_of_Birth
    {
        get
        {
            return _date_of_Birth;
        }
        set
        {
            _date_of_Birth = value;
        }
    }

    public int gender
    {
        get
        {
            return _gender;
        }
        set
        {
            _gender = value;
        }
    }

    public double height
    {
        get
        {
            return _height;
        }
        set
        {
            _height = value;
        }
    }

    public double weight
    {
        get
        {
            return _weight;
        }
        set
        {
            _weight = value;
        }
    }

    public string applyclass
    {
        get
        {
            return _applyclass;
        }
        set
        {
            _applyclass = value;
        }
    }

    public string section
    {
        get
        {
            return _section;
        }
        set
        {
            _section = value;
        }
    }

    public int sectionid
    {
        get
        {
            return _sectionid;
        }
        set
        {
            _sectionid = value;
        }
    }

    public int classid
    {
        get
        {
            return _classid;
        }
        set
        {
            _classid = value;
        }
    }

    public string upload_student_image
    {
        get
        {
            return _upload_student_image;
        }
        set
        {
            _upload_student_image = value;
        }
    }

    public string student_age
    {
        get
        {
            return _student_age;
        }
        set
        {
            _student_age = value;
        }
    }

    public int transportation
    {
        get
        {
            return _transportation;
        }
        set
        {
            _transportation = value;
        }
    }

    public string nationality
    {
        get
        {
            return _nationality;
        }
        set
        {
            _nationality = value;
        }
    }

    public string houseno
    {
        get
        {
            return _houseno;
        }
        set
        {
            _houseno = value;
        }
    }

    public string appartment
    {
        get
        {
            return _appartment;
        }
        set
        {
            _appartment = value;
        }
    }

    public string street
    {
        get
        {
            return _street;
        }
        set
        {
            _street = value;
        }
    }

    public string landmark
    {
        get
        {
            return _landmark;
        }
        set
        {
            _landmark = value;
        }
    }

    public string pincode
    {
        get
        {
            return _pincode;
        }
        set
        {
            _pincode = value;
        }
    }

    public string languages_spoken
    {
        get
        {
            return _languages_spoken;
        }
        set
        {
            _languages_spoken = value;
        }
    }

    public string father_Name
    {
        get
        {
            return _father_Name;
        }
        set
        {
            _father_Name = value;
        }
    }

    public int father_QualificatioID
    {
        get
        {
            return _father_QualificatioID;
        }
        set
        {
            _father_QualificatioID = value;
        }
    }

    public string father_Occupation
    {
        get
        {
            return _father_Occupation;
        }
        set
        {
            _father_Occupation = value;
        }
    }

    public string father_Organisation
    {
        get
        {
            return _father_Organisation;
        }
        set
        {
            _father_Organisation = value;
        }
    }

    public string father_PhoneNo_Residential
    {
        get
        {
            return _father_PhoneNo_Residential;
        }
        set
        {
            _father_PhoneNo_Residential = value;
        }
    }

    public string father_PhoneNo_Office
    {
        get
        {
            return _father_PhoneNo_Office;
        }
        set
        {
            _father_PhoneNo_Office = value;
        }
    }

    public string father_MobileNo
    {
        get
        {
            return _father_MobileNo;
        }
        set
        {
            _father_MobileNo = value;
        }
    }

    public string father_Email
    {
        get
        {
            return _father_Email;
        }
        set
        {
            _father_Email = value;
        }
    }

    public string Fqualification_other
    {
        get
        {
            return _Fqualification_other;
        }
        set
        {
            _Fqualification_other = value;
        }
    }

    //mother

    public string mother_Name
    {
        get
        {
            return _mother_Name;
        }
        set
        {
            _mother_Name = value;
        }
    }

    public int mother_QualificatioID
    {
        get
        {
            return _mother_QualificatioID;
        }
        set
        {
            _mother_QualificatioID = value;
        }
    }

    public string mother_Occupation
    {
        get
        {
            return _mother_Occupation;
        }
        set
        {
            _mother_Occupation = value;
        }
    }

    public string mother_Organisation
    {
        get
        {
            return _mother_Organisation;
        }
        set
        {
            _mother_Organisation = value;
        }
    }

    public string mother_PhoneNo_Residential
    {
        get
        {
            return _mother_PhoneNo_Residential;
        }
        set
        {
            _mother_PhoneNo_Residential = value;
        }
    }

    public string mother_PhoneNo_Office
    {
        get
        {
            return _mother_PhoneNo_Office;
        }
        set
        {
            _mother_PhoneNo_Office = value;
        }
    }

    public string mother_MobileNo
    {
        get
        {
            return _mother_MobileNo;
        }
        set
        {
            _mother_MobileNo = value;
        }
    }

    public string mother_Email
    {
        get
        {
            return _mother_Email;
        }
        set
        {
            _mother_Email = value;
        }
    }

    public string mother_other
    {
        get
        {
            return _Mqualification_other;
        }
        set
        {
            _Mqualification_other = value;
        }
    }

    //sibling details

    public string SibName1
    {
        get
        {
            return _SibName1;
        }
        set
        {
            _SibName1 = value;
        }
    }

    public string Sibage1
    {
        get
        {
            return _Sibage1;
        }
        set
        {
            _Sibage1 = value;
        }
    }

    public string Sibschool1
    {
        get
        {
            return _Sibschool1;
        }
        set
        {
            _Sibschool1 = value;
        }
    }

    public string SibName2
    {
        get
        {
            return _SibName2;
        }
        set
        {
            _SibName2 = value;
        }
    }

    public string Sibage2
    {
        get
        {
            return _Sibage2;
        }
        set
        {
            _Sibage2 = value;
        }
    }

    public string Sibschool2
    {
        get
        {
            return _Sibschool2;
        }
        set
        {
            _Sibschool2 = value;
        }
    }

    public string SibName3
    {
        get
        {
            return _SibName3;
        }
        set
        {
            _SibName3 = value;
        }
    }

    public string Sibage3
    {
        get
        {
            return _Sibage3;
        }
        set
        {
            _Sibage3 = value;
        }
    }

    public string Sibschool3
    {
        get
        {
            return _Sibschool3;
        }
        set
        {
            _Sibschool3 = value;
        }
    }

    public int previous_schooling
    {
        get
        {
            return _previous_schooling;
        }
        set
        {
            _previous_schooling = value;
        }
    }

    public string previous_schooling_details
    {
        get
        {
            return _previous_schooling_details;
        }
        set
        {
            _previous_schooling_details = value;
        }
    }

    public int bloodid
    {
        get
        {
            return _bloodid;
        }
        set
        {
            _bloodid = value;
        }
    }

    public string Specific_ailments_Suffered
    {
        get
        {
            return _Specific_ailments_Suffered;
        }
        set
        {
            _Specific_ailments_Suffered = value;
        }
    }

    public string Surgery_undergone
    {
        get
        {
            return _Surgery_undergone;
        }
        set
        {
            _Surgery_undergone = value;
        }
    }

    public string allergy
    {
        get
        {
            return _allergy;
        }
        set
        {
            _allergy = value;
        }
    }

    public int regular_medication_status
    {
        get
        {
            return _regular_medication_status;
        }
        set
        {
            _regular_medication_status = value;
        }
    }

    public string regular_medication_Detial
    {
        get
        {
            return _regular_medication_Detial;
        }
        set
        {
            _regular_medication_Detial = value;
        }
    }

    public int phobias_status
    {
        get
        {
            return _phobias_status;
        }
        set
        {
            _phobias_status = value;
        }
    }

    public string phobias_Detial
    {
        get
        {
            return _phobias_Detial;
        }
        set
        {
            _phobias_Detial = value;
        }
    }

    public string vaccination_name
    {
        get
        {
            return _vaccination_name;
        }
        set
        {
            _vaccination_name = value;
        }
    }

    public string vaccination_id
    {
        get
        {
            return _vaccination_id;
        }
        set
        {
            _vaccination_id = value;
        }
    }

    public string Any_specific_Instruction
    {
        get
        {
            return _Any_specific_Instruction;
        }
        set
        {
            _Any_specific_Instruction = value;
        }
    }

    public string EMERGENCY_CONTACT_name1
    {
        get
        {
            return _EMERGENCY_CONTACT_name1;
        }
        set
        {
            _EMERGENCY_CONTACT_name1 = value;
        }
    }

    public string EMERGENCY_mobileno1
    {
        get
        {
            return _EMERGENCY_mobileno1;
        }
        set
        {
            _EMERGENCY_mobileno1 = value;
        }
    }

    public string emergency_address1
    {
        get
        {
            return _emergency_address1;
        }
        set
        {
            _emergency_address1 = value;
        }
    }

    public string EMERGENCY_CONTACT_name2
    {
        get
        {
            return _EMERGENCY_CONTACT_name2;
        }
        set
        {
            _EMERGENCY_CONTACT_name2 = value;
        }
    }

    public string EMERGENCY_mobileno2
    {
        get
        {
            return _EMERGENCY_mobileno2;
        }
        set
        {
            _EMERGENCY_mobileno2 = value;
        }
    }

    public string emergency_address2
    {
        get
        {
            return _emergency_address2;
        }
        set
        {
            _emergency_address2 = value;
        }
    }

    public string signature_upolad
    {
        get
        {
            return _signature_upolad;
        }
        set
        {
            _signature_upolad = value;
        }
    }

    public string name_of_signee
    {
        get
        {
            return _name_of_signee;
        }
        set
        {
            _name_of_signee = value;
        }
    }

    public string relation_to_child
    {
        get
        {
            return _relation_to_child;
        }
        set
        {
            _relation_to_child = value;
        }
    }

    public string feeid
    {
        get
        {
            return _feeid;
        }
        set
        {
            _feeid = value;
        }
    }

    public string FeeName
    {
        get
        {
            return _FeeName;
        }
        set
        {
            _FeeName = value;
        }
    }

    public string FeeAmount
    {
        get
        {
            return _FeeAmount;
        }
        set
        {
            _FeeAmount = value;
        }
    }

    public string Discount
    {
        get
        {
            return _Discount;
        }
        set
        {
            _Discount = value;
        }
    }

    public string ckdisid
    {
        get
        {
            return _ckdisid;
        }
        set
        {
            _ckdisid = value;
        }
    }

    public string paymodeid
    {
        get
        {
            return _paymodeid;
        }
        set
        {
            _paymodeid = value;
        }
    }

    public string bankname
    {
        get
        {
            return _bankname;
        }
        set
        {
            _bankname = value;
        }
    }

    public string checkno
    {
        get
        {
            return _checkno;
        }
        set
        {
            _checkno = value;
        }
    }

    public double payableamt
    {
        get
        {
            return _payableamt;
        }
        set
        {
            _payableamt = value;
        }
    }

    public double paynowamount
    {
        get
        {
            return _paynowamount;
        }
        set
        {
            _paynowamount = value;
        }
    }

    public string monthids
    {
        get
        {
            return _monthids;
        }
        set
        {
            _monthids = value;
        }
    }

    public string mode
    {
        get
        {
            return _mode;
        }
        set
        {
            _mode = value;
        }
    }

    public string paytypename
    {
        get
        {
            return _paytypename;
        }
        set
        {
            _paytypename = value;
        }
    }

    public int paytypeID
    {
        get
        {
            return _paytypeID;
        }
        set
        {
            _paytypeID = value;
        }
    }

    public string feepaynow
    {
        get
        {
            return _feepaynow;
        }
        set
        {
            _feepaynow = value;
        }
    }

    public DateTime signaturedate
    {
        get
        {
            return _signaturedate;
        }
        set
        {
            _signaturedate = value;
        }
    }

    public static int pagesize
    {
        get
        {
            return _pagesize;
        }
        set
        {
            _pagesize = value;
        }
    }

    public static int currentpage
    {
        get
        {
            return _currentpage;
        }
        set
        {
            _currentpage = value;
        }
    }

    public static string feetype
    {
        get
        {
            return _feetype;
        }
        set
        {
            _feetype = value;
        }
    }

    public static int monthid
    {
        get
        {
            return _monthid;
        }
        set
        {
            _monthid = value;
        }
    }

    public static double totalfee
    {
        get
        {
            return _totalfee;
        }
        set
        {
            _totalfee = value;
        }
    }

    public static double paidfee
    {
        get
        {
            return _paidfee;
        }
        set
        {
            _paidfee = value;
        }
    }

    public static double balfee
    {
        get
        {
            return _balfee;
        }
        set
        {
            _balfee = value;
        }
    }

    public static double recevied
    {
        get
        {
            return _recevied;
        }
        set
        {
            _recevied = value;
        }
    }

    public static string sttype
    {
        get
        {
            return _sttype;
        }
        set
        {
            _sttype = value;
        }
    }

    public static int adid
    {
        get
        {
            return _adid;
        }
        set
        {
            _adid = value;
        }
    }

    public static int feeTypeid
    {
        get
        {
            return _feeTypeid;
        }
        set
        {
            _feeTypeid = value;
        }
    }

    public double actualfine
    {
        get
        {
            return _actualfine;
        }
        set
        {
            _actualfine = value;
        }
    }

    public int adid2
    {
        get
        {
            return _adid2;
        }
        set
        {
            _adid2 = value;
        }
    }

    public string finepayornot
    {
        get
        {
            return _finepayornot;
        }
        set
        {
            _finepayornot = value;
        }
    }

    public double totalfine
    {
        get
        {
            return _totalfine;
        }
        set
        {
            _totalfine = value;
        }
    }

    public int nextmonthid
    {
        get
        {
            return _nextmonthid;
        }
        set
        {
            _nextmonthid = value;
        }
    }

    public string bankbranch
    {
        get
        {
            return _bankbranch;
        }
        set
        {
            _bankbranch = value;
        }
    }

    public DateTime draftdate
    {
        get
        {
            return _draft_date;
        }
        set
        {
            _draft_date = value;
        }
    }
}